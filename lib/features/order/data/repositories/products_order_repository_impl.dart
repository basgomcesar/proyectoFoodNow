import 'package:dartz/dartz.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import '../../domain/repositories/products_order_repository.dart';
import '/core/error/failure.dart';
import '../datasources/order_remote_data_source.dart';

class ProductsOrderRepositoryImpl implements ProductsOrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  ProductsOrderRepositoryImpl(this.remoteDataSource);

  @override
  Stream<Either<Failure, ProductsOrder>> getPendingOrders() async* {
    try {
      await for (final order in remoteDataSource.getPendingOrders()) {
        yield Right(order);
      }
    } on ServerFailure catch (e) {
      print('Error en el repositorio: ${e.message}');
      yield Left(ServerFailure(e.message));
    } on UnknownFailure catch (e) {
      print('Error desconocido en el repositorio: ${e.message}');
      yield Left(UnknownFailure(e.message));
    } catch (e, stackTrace) {
      print('Error inesperado en getPendingOrders: $e');
      print('StackTrace: $stackTrace');
      yield Left(UnknownFailure('Ocurrió un error inesperado.'));
    }
  }
}
