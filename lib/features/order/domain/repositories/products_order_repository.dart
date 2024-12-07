import 'package:dartz/dartz.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import '/core/error/failure.dart';

abstract class ProductsOrderRepository {
  Stream<Either<Failure, ProductsOrder>> getPendingOrders();
}