import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:loging_app/features/user/domain/entities/product.dart';
import 'package:loging_app/core/error/failure.dart';

abstract class ProductRepository {
  
  Future<Either<Failure, bool>> addProduct(String name,  String description, double price, Uint8List photo, int availableQuantity, bool disponibility, String category);  

}
