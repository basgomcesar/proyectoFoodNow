import 'package:dartz/dartz.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import '../../domain/repositories/products_order_repository.dart';
import '/core/error/failure.dart';
import '../datasources/order_remote_data_source.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductOrder>>> getPendingOrders() async {
    try {
      final orders = await remoteDataSource.getPendingOrders();
      if (orders.isNotEmpty) {
        return Right(orders);
      } else {
        return Left(UnknownFailure('No hay órdenes pendientes.'));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on UnknownFailure catch (e) {
      return Left(UnknownFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Ocurrió un error inesperado.'));
    }
  }

  @override
  Future<Either<Failure, List<ProductOrder>>> getCustomerOrders() async {
    try {
      final orders = await remoteDataSource.getCustomerOrders();
      if (orders.isNotEmpty) {
        return Right(orders);
      } else {
        return Left(UnknownFailure('No tienes pedidos activos.'));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on UnknownFailure catch (e) {
      return Left(UnknownFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Ocurrió un error inesperado.'));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelOrder(int idOrder) async {
    try {
      final canceledOrder = await remoteDataSource.cancelOrder(idOrder);
      return Right(canceledOrder);
    } on DuplicateProductFailure catch (e) {
      return Left(DuplicateProductFailure(e.message));
    } on InvalidDataFailure catch (e) {
      return Left(InvalidDataFailure(e.message));
    } on InvalidPriceFailure catch (e) {
      return Left(InvalidPriceFailure(e.message));
    } on UnknownFailure catch (e) {
      return Left(UnknownFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Ocurrió un error inesperado.'));
    }
  }

  @override
  Future<Either<Failure, bool>> confirmOrder(int idOrder) async {
    try {
      final confirmedOrder = await remoteDataSource.confirmOrder(idOrder);
      return Right(confirmedOrder);
    } on DuplicateProductFailure catch (e) {
      return Left(DuplicateProductFailure(e.message));
    } on InvalidDataFailure catch (e) {
      return Left(InvalidDataFailure(e.message));
    } on InvalidPriceFailure catch (e) {
      return Left(InvalidPriceFailure(e.message));
    } on UnknownFailure catch (e) {
      return Left(UnknownFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Ocurrió un error inesperado.'));
    }
  }
}
