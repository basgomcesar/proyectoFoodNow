import 'dart:async';
import 'package:dio/dio.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/core/utils/session.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import 'package:loging_app/features/order/data/models/products_order_model.dart';

abstract interface class OrderRemoteDataSource {
  /// Recupera una lista de pedidos pendientes desde el servidor
  Future<List<ProductsOrder>> getPendingOrders();
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio dioClient = Dio();
  final String apiUrl = 'http://localhost:3000'; // URL de tu API
  final Session session = Session.instance;

  @override
  Future<List<ProductsOrder>> getPendingOrders() async {
    try {
      print('Fetching pending orders from the server...');
      final response = await dioClient.get(
        '$apiUrl/pedidos/activos/usuario', // Endpoint para pedidos pendientes
        options: Options(
          headers: {
            'x-token': session.token, // Token de sesión
          },
        ),
      );
      print('Response data: ${response.data}'); // Verificar el contenido de la respuesta

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
        // Si el código de estado no es 200, manejar el error
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