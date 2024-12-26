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
  Future<Product> getOrderProduct(int idPedido);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {

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
  Future<Product> getOrderProduct(int idPedido) async {
    try {
      print('Fetching product for order ID: $idPedido...');
      
      final response = await dioClient.get(
        '$apiUrl/orderproducts/$idPedido', // Endpoint para obtener producto de un pedido
        options: Options(
          headers: {
            'x-token': session.token, // Token de sesión
          },
        ),
      );

      print('Response data: ${response.data}'); // Log para verificar el contenido de la respuesta

      if (response.statusCode == 200) {
        if (response.data == null) {
          throw ServerFailure('La respuesta del servidor es nula.');
        }

        final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

        if (responseData.containsKey('productos')) {
          final productos = responseData['productos'];

          // Comprobamos que 'productos' contiene un producto válido
          if (productos != null && productos is List && productos.isNotEmpty) {
            // Asumimos que un pedido tiene un único producto
            final productJson = productos.first;
            return ProductModel.fromJson(productJson).toDomain();
          } else {
            // Si 'productos' está vacío o no es válido, manejar el error
            throw ServerFailure('No se encontró un producto válido para el pedido.');
          }
        } else {
          throw ServerFailure('Respuesta del servidor no contiene la clave "productos".');
        }
      } else if (response.statusCode == 404) {
        throw NotFoundFailure('No se encontró un producto para el pedido con ID: $idPedido.');
      } else {
        throw ServerFailure(
          'Error al obtener el producto del pedido. Código: ${response.statusCode}',
        );
      }
    } on DioException catch (dioError) {
      print('Error al conectar con el servidor: ${dioError.message}');
      throw ServerFailure('Error al conectar con el servidor.');
    } catch (error) {
      print('Error inesperado: $error');
      throw ServerFailure('Error inesperado al obtener el producto del pedido.');
    }
  }

}
