import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import '../entities/product_graph.dart';

abstract class ProductOfferedRepository {
  Future<Either<Failure, List<ProductGraph>>> getProductsOffered( String anio, String mes);
}