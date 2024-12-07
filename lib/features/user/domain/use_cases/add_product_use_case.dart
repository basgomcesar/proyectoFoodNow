
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/user/domain/repositories/product_repository.dart';

class AddProductUseCase {
  final ProductRepository repository;

  AddProductUseCase({required this.repository});

  Future<Either<Failure, bool>> call(String name,  String description, double price, Uint8List photo, int availableQuantity, bool disponibility, String category) async {      
    return await repository.addProduct(name, description, price, photo, availableQuantity, disponibility, category);      
  }  
  
}

