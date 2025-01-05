import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';
import 'package:loging_app/features/product/domain/repositories/product_repository.dart';

class GetOrderProduct {
  final ProductRepository repository;

    GetOrderProduct({required this.repository});

    Future<Either<Failure, Product>> call(int idPedido) async {      
    return await repository.getOrderProduct(idPedido);
  }  
}