import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/order/domain/repositories/products_order_repository.dart';

class ConfirmOrderUseCase{
  final OrderRepository repository;

  ConfirmOrderUseCase({required this.repository});

  Future<Either<Failure, bool>> call(int idOrder) async{
    return await repository.confirmOrder(idOrder);
  }
}