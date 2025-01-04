import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/core/utils/session.dart';
import 'package:loging_app/features/product/data/models/product_order_model.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';

import '../models/product_model.dart';
import 'package:grpc/grpc.dart';
import '../../../../generated/productos.pbgrpc.dart';



abstract class ProductRemoteDataSource {
  Stream<ProductModel> getProducts();
  Future<bool> addProduct(ProductModel productModel);
  Future<ProductOrderModel> placeOrder(ProductModel productModel, int quantity);
  
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {

  final ClientChannel channel;
  late final ProductServiceClient client;
  final Dio dioClient = Dio();
  final String apiUrl ; // URL de tu API
  final Session session = Session.instance;

  ProductRemoteDataSourceImpl(this.channel,{required this.apiUrl}) {
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
        '$apiUrl/products',
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
  
@override
  Future<ProductOrderModel> placeOrder(Product product, int quantity) async {
    try {
      final response = await dioClient.post(
        '$apiUrl/orders',
        data: {
          'product_id': product.id,
          'quantity': quantity,
        },
        options: Options(
          headers: {
            'x-token': session.token,
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      switch (response.statusCode) {
        case 201:
          return ProductOrderModel.fromJson(response.data); // Orden creada exitosamente
        case 400:
          throw InvalidDataFailure('Datos inválidos enviados al servidor.');
        case 404:
          throw OrderFailure('Producto no encontrado.');
        case 500:
          throw ServerFailure('Error en el servidor. Inténtalo más tarde.');
        default:
          throw UnknownFailure(
            'Error desconocido: ${response.statusCode}',
          );
      }
    } catch (e) {
      print('Error en placeOrder: $e');
      rethrow;
    }
  }

}
