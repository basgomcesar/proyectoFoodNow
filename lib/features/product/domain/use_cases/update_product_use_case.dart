import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/product/data/models/product_model.dart';
import 'package:loging_app/features/product/domain/repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository repository;

  UpdateProductUseCase({required this.repository});

  Future<Either<Failure, bool>> call(ProductModel product) async {      
    return await repository.updateProduct(product);
    }
}