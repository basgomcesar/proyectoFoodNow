
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';
import 'package:loging_app/features/product/domain/repositories/product_repository.dart';

class AddProductUseCase {
  final ProductRepository repository;

  AddProductUseCase({required this.repository});

  Future<Either<Failure, bool>> call(Product product) async {      
    return await repository.addProduct(product);      
  }  
  
}

