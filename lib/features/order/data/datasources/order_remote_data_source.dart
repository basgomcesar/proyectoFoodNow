import 'dart:async';
import 'package:dio/dio.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/core/utils/session.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import 'package:loging_app/features/order/data/models/products_order_model.dart';

abstract interface class OrderRemoteDataSource {
  Future<List<ProductOrder>> getPendingOrders();
  Future<List<ProductOrder>> getCustomerOrders();
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio dioClient = Dio();
  final String apiUrl = 'http://localhost:3000'; // URL de tu API
  final Session session = Session.instance;

  @override
  Future<List<ProductOrder>> getPendingOrders() async {
    try {
      final response = await dioClient.get(
        '$apiUrl/orders/pending/seller',
        options: Options(
          headers: {
            'x-token': session.token, // Token de sesión
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data == null) {
          throw ServerFailure('La respuesta del servidor es nula.');
        }

        // Asegurarnos de que la respuesta contiene la clave 'pedidos' y que no es null
        final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

        if (responseData.containsKey('pedidos')) {
          final pedidos = responseData['pedidos'];

          // Comprobamos que 'pedidos' sea una lista
          if (pedidos != null && pedidos is List) {
            
            return pedidos
                .map((orderJson) => ProductsOrderModel.fromJson(orderJson).toDomain())
                .toList();
          } else {
            // Si 'pedidos' no es una lista, manejar el error
            throw ServerFailure('Formato de respuesta inesperado: "pedidos" no es una lista.');
          }
        } else {
          throw ServerFailure('Respuesta del servidor no contiene la clave "pedidos".');
        }
      } else {
        throw ServerFailure(
          'Error al obtener pedidos pendientes. Código: ${response.statusCode}',
        );
      }
    } on DioException catch (dioError) {
      print('Error al conectar con el servidor: ${dioError.message}');
      throw ServerFailure('Error al conectar con el servidor.');
    } catch (error) {
      print('Error inesperado: $error');
      throw ServerFailure('Error inesperado al obtener pedidos pendientes.');
    }
  }
  
  @override
  Future<List<ProductOrder>> getCustomerOrders() async {
    try {
      final response = await dioClient.get(
        '$apiUrl/orders/pending/customer',
        options: Options(
          headers: {
            'x-token': session.token, // Token de sesión
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data == null) {
          throw ServerFailure('La respuesta del servidor es nula.');
        }

        // Asegurarnos de que la respuesta contiene la clave 'pedidos' y que no es null
        final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

        if (responseData.containsKey('pedidos')) {
          final pedidos = responseData['pedidos'];

          // Comprobamos que 'pedidos' sea una lista
          if (pedidos != null && pedidos is List) {
            
            return pedidos
                .map((orderJson) => ProductsOrderModel.fromJson(orderJson).toDomain())
                .toList();
          } else {
            // Si 'pedidos' no es una lista, manejar el error
            throw ServerFailure('Formato de respuesta inesperado: "pedidos" no es una lista.');
          }
        } else {
          throw ServerFailure('Respuesta del servidor no contiene la clave "pedidos".');
        }
      } else {
        throw ServerFailure(
          'Error al obtener pedidos pendientes. Código: ${response.statusCode}',
        );
      }
    } on DioException catch (dioError) {
      print('Error al conectar con el servidor: ${dioError.message}');
      throw ServerFailure('Error al conectar con el servidor.');
    } catch (error) {
      print('Error inesperado: $error');
      throw ServerFailure('Error inesperado al obtener pedidos pendientes.');
    }
  }
}