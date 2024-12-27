import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import 'package:loging_app/features/order/domain/repositories/products_order_repository.dart';

class GetPendingOrders {
  final OrderRepository orderRepository;
  const GetPendingOrders(this.orderRepository);

  Future<Either<Failure, List<ProductOrder>>> call() {
    return orderRepository.getPendingOrders();
  }
}