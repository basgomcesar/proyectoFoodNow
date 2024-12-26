import 'package:dartz/dartz.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import '../../domain/repositories/products_order_repository.dart';
import '/core/error/failure.dart';
import '../datasources/order_remote_data_source.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductsOrder>>> getPendingOrders() async {
    try {
      final orders = await remoteDataSource.getPendingOrders();
      if (orders.isNotEmpty) {
        return Right(orders);
      } else {
        return Left(UnknownFailure('No hay órdenes pendientes.'));
      }
    } on ServerFailure catch (e) {
      print('Error en el repositorio: ${e.message}');
      return Left(ServerFailure(e.message));
    } on UnknownFailure catch (e) {
      print('Error desconocido en el repositorio: ${e.message}');
      return Left(UnknownFailure(e.message));
    } catch (e, stackTrace) {
      print('Error inesperado en getPendingOrders: $e');
      print('StackTrace: $stackTrace');
      return Left(UnknownFailure('Ocurrió un error inesperado.'));
    }
  }
}
