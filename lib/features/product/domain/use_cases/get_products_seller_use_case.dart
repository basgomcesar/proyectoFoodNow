import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_rest_repository.dart';

class GetProductsSellerUseCase {
  final ProductRestRepository repositoryProduct;

  GetProductsSellerUseCase({required this.repositoryProduct});

  Future<Either<Failure, List<Product>>> call(String sellerId) async {
    return repositoryProduct.getProductsSeller(sellerId);
  }
}
