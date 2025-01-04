import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/product_graph.dart';
import '../repositories/product_rest_repository.dart';

class GetProductsOfferedUseCase {
  final ProductRestRepository repositoryProduct;

  GetProductsOfferedUseCase({required this.repositoryProduct});

  Future<Either<Failure, List<ProductGraph>>> call(
      String userId, String anio, String mes) async {
    return await repositoryProduct.getProductsOffered(userId, anio, mes);
  }
}