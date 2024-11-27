import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../../../core/error/failure.dart';

class GetProductsOfferedUseCase {
  final ProductRepository repository;

  GetProductsOfferedUseCase({required this.repository});

  Future<Either<Failure, List<Product>>> call(String userId) async {      
    return await repository.getProductsOffered(userId);   
  }
}
