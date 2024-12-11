import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/core/utils/session.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';

import '../models/product_model.dart';
import 'package:grpc/grpc.dart';
import '../../../../generated/productos.pbgrpc.dart';



abstract class ProductRemoteDataSource {
  Stream<ProductModel> getProducts();
  Future<bool> addProduct(ProductModel productModel);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {

  final Dio productsSeller = Dio();
  // Eliminar la referencia a FirebaseFirestore
  final String apiUrl = 'http://localhost:3000'; // URL de tu API
  final Session session = Session.instance;

  final ClientChannel channel;
  late final ProductServiceClient client;
  final Dio dioClient = Dio();
  final String apiUrl = 'http://localhost:3000'; // URL de tu API
  final Session session = Session.instance;

  ProductRemoteDataSourceImpl(this.channel) {
    client = ProductServiceClient(channel);
  }
  
  @override
  Stream<ProductModel> getProducts() async* {
    try {
      print('Getting products from server');
      final request = ProductUpdateRequest();
      final responseStream = client.subscribeToProductUpdates(request);
      await for (var product in responseStream) {
        yield ProductModel.fromGrpc(product);
      }
    } catch (e) {
      print('Error getting products: $e');
      rethrow;
    }
  }

  @override
  Future<bool> addProduct(ProductModel productModel) async {   
    print(productModel.toFormData());

    try {
      final response = await dioClient.post(
        '$apiUrl/productos',
        data: productModel.toFormData(),
        options: Options(
          headers: {
            'x-token': session.token, 
          },
          validateStatus: (status) => status! < 500, // Manejar errores del servidor
        ),
      );

      switch (response.statusCode) {
        case 201:
          return true; // Producto creado exitosamente
        case 409:
          throw DuplicateProductFailure(
              'Ya tienes un producto con este nombre registrado.');
        case 400:
          throw InvalidDataFailure('Datos inválidos enviados al servidor.');
        case 422:
          throw InvalidPriceFailure('Precio inválido, se acepta hasta 2 decimales.');
        case 500:
          throw ServerFailure('Error en el servidor. Inténtalo más tarde.');
        default:
          throw UnknownFailure(
            'Error desconocido: ${response.statusCode}',
          );
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }


}
