import 'dart:convert';
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
  Future<Product> getOrderProduct(int idOrder);
  Future<bool> updateProduct(ProductModel updatedProduct);
  Future<bool> deleteProduct(int idProduct);
  Future<ProductOrderModel> placeOrder(ProductModel productModel, int quantity);
  
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ClientChannel channel;
  late final ProductServiceClient client;
  final Dio dioClient = Dio();
  final String apiUrl ;
  final Session session = Session.instance;

  ProductRemoteDataSourceImpl(this.channel,{required this.apiUrl}) {
    client = ProductServiceClient(channel);
  }

  @override
  Stream<ProductModel> getProducts() async* {
    try {
      final request = ProductUpdateRequest();
      final responseStream = client.subscribeToProductUpdates(request);
      await for (var product in responseStream) {
        yield ProductModel.fromGrpc(product);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> addProduct(ProductModel productModel) async {
    try {
      final response = await dioClient.post(
        '$apiUrl/products',
        data: productModel.toFormData(),
        options: Options(
          headers: {
            'x-token': session.token,
          },
          validateStatus: (status) =>
              status! < 500,
        ),
      );

      switch (response.statusCode) {
        case 201:
          return true;
        case 409:
          throw DuplicateProductFailure(
              'Ya tienes un producto con este nombre registrado.');
        case 400:
          throw InvalidDataFailure('Datos inválidos enviados al servidor.');
        case 422:
          throw InvalidPriceFailure(
              'Precio inválido, se acepta hasta 2 decimales.');
        case 500:
          throw ServerFailure('Error en el servidor. Inténtalo más tarde.');
        default:
          throw UnknownFailure(
            'Error desconocido: ${response.statusCode}',
          );
      }
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Product> getOrderProduct(int idPedido) async {
    try {
      final response = await dioClient.get(
        '$apiUrl/products/orderproducts/$idPedido',
        options: Options(
          headers: {
            'x-token': session.token,
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data == null) {
          throw ServerFailure('La respuesta del servidor es nula.');
        }

        final Map<String, dynamic> responseData =
            response.data as Map<String, dynamic>;

        if (responseData.containsKey('productos') &&
            responseData['productos'] != null) {
          final productos = responseData['productos'];

          if (productos is List && productos.isNotEmpty) {
            final productJson = productos.first;

            if (productJson['foto'] is Map<String, dynamic>) {
              final fotoMap = productJson['foto'] as Map<String, dynamic>;

              if (fotoMap.containsKey('data')) {
                final fotoBytes = List<int>.from(fotoMap['data']);
                productJson['foto'] = base64Encode(fotoBytes);
              } else {
                productJson['foto'] = '';
              }
            } else {
              productJson['foto'] = productJson['foto'] ?? '';
            }
            return ProductModel.fromJsonEsp(productJson).toDomain();
          } else {
            throw ServerFailure(
                'No se encontró un producto válido para el pedido.');
          }
        } else {
          throw ServerFailure(
              'Respuesta del servidor no contiene la clave "productos" o es nula.');
        }
      } else if (response.statusCode == 404) {
        throw NotFoundFailure(
            'No se encontró un producto para el pedido con ID: $idPedido.');
      } else {
        throw ServerFailure(
          'Error al obtener el producto del pedido. Código: ${response.statusCode}',
        );
      }
    } on DioException catch (dioError) {
      throw ServerFailure('Error al conectar con el servidor. ${dioError.message}');
    } catch (error) {
      throw ServerFailure(
          'Error inesperado al obtener el producto del pedido.');
    }
  }

  @override
  Future<bool> deleteProduct(int idProduct) async{
    try {
      
      final response = await dioClient.delete(
        '$apiUrl/products/delete/$idProduct',
        options: Options(
          headers: {
            'x-token': session.token,
          },
          validateStatus: (status) =>
              status! < 500,
        ),
      );

      print("status code: ${response.statusCode}");

      if (response.statusCode == 200){
        return true;
      } else {
        return false;
      }

    } on DioException catch (dioError) {
      throw ServerFailure('Error al conectar con el servidor. ${dioError.message}');
    } catch (error) {
      throw ServerFailure('Error inesperado al obtener el producto del pedido. $error');
    }
  }

  @override
  Future<bool> updateProduct(ProductModel updatedProduct) async {
    try {
      final response = await dioClient.put(
        '$apiUrl/products/update/${updatedProduct.id}',
        data: {
          if (updatedProduct.description != null)
            'descripcion': updatedProduct.description,
          'precio': updatedProduct.price,
          'cantidadDisponible': updatedProduct.quantityAvailable,
        },
        options: Options(
          headers: {
            'x-token': session.token,
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      switch (response.statusCode) {
        case 200:
          return true;
        case 404:
          throw NotFoundFailure(
              'El producto no fue encontrado o no pertenece al usuario.');
        case 400:
          throw InvalidDataFailure(
              'Datos inválidos enviados al servidor para la actualización.');
        case 500:
          throw ServerFailure('Error en el servidor. Inténtalo más tarde.');
        default:
          throw UnknownFailure(
            'Error desconocido: ${response.statusCode}',
          );
      }
    } on DioException catch (dioError) {
      throw ServerFailure('Error al conectar con el servidor. ${dioError.message}');
    } catch (error) {
      throw ServerFailure('Error inesperado al actualizar el producto. $error');
    }
  }
  
  @override
  Future<ProductOrderModel> placeOrder(Product product, int quantity) async {
    try {
      final response = await dioClient.post(
        '$apiUrl/orders',
        data: {
          'idProducto': product.id,
          'cantidad': quantity,
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
          return ProductOrderModel.fromJson(response.data['order']);
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
      rethrow;
    }
  }

}
