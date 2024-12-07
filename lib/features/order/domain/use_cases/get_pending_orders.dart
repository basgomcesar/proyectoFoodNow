import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import 'package:loging_app/features/order/domain/repositories/products_order_repository.dart';

class GetPendingOrders {
  final ProductsOrderRepository orderRepository;

  GetPendingOrders({required this.orderRepository});

  Stream<Either<Failure, ProductsOrder>> call() {
    return orderRepository.getPendingOrders();
  }
}