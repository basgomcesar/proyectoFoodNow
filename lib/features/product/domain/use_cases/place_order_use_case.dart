

import 'package:dartz/dartz.dart';

import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/product/domain/entities/product_order.dart';

import '../entities/product.dart';
import '../repositories/product_repository.dart';

class PlaceOrderUseCase {
  final ProductRepository repository;

  PlaceOrderUseCase({required this.repository});

  Future<Either<Failure, ProductOrder>> call(Product product, int quantity) async {
    return await repository.placeOrder(product, quantity);
  }
}