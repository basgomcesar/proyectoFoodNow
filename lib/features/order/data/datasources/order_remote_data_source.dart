import 'dart:async';
import 'package:dio/dio.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/core/utils/session.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import 'package:loging_app/features/order/data/models/products_order_model.dart';

abstract interface class OrderRemoteDataSource {
  /// Recupera una lista de pedidos pendientes desde el servidor como un flujo de datos
  Stream<ProductsOrder> getPendingOrders();
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio dioClient = Dio();
  final String apiUrl = 'http://localhost:3000'; // URL de tu API
  final Session session = Session.instance;

  @override
  Stream<ProductsOrder> getPendingOrders() async* {
    try {
      print('Fetching pending orders from the server...');
      final response = await dioClient.get(
        '$apiUrl/activos/usuario', // Endpoint para pedidos pendientes
        options: Options(
          headers: {
            'x-token': session.token, // Token de sesión
          },
        ),
      );

      if (response.statusCode == 200) {
        // Suponiendo que la respuesta es una lista de pedidos en formato JSON
        final List<dynamic> ordersJson = response.data as List<dynamic>;

        for (var orderJson in ordersJson) {
          yield ProductsOrderModel.fromJson(orderJson).toDomain();
        }
      } else {
        throw ServerFailure(
          'Error al obtener pedidos pendientes. Código: ${response.statusCode}',
        );
      }
    } on DioException catch (dioError) {
      print('Error al conectar con el servidor: ${dioError.message}');
      throw ServerFailure('Error al conectar con el servidor.');
    } catch (e) {
      print('Error desconocido: $e');
      throw UnknownFailure('Error desconocido: $e');
    }
  }
}
