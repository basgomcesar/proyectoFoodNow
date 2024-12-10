import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import '../entities/product.dart';
import '../entities/product_graph.dart';

abstract class ProductRestRepository {
  Future<Either<Failure, List<ProductGraph>>> getProductsOffered(String userId, String anio, String mes);
  Future<Either<Failure, List<Product>>> getProductsSeller(String sellerId);
}