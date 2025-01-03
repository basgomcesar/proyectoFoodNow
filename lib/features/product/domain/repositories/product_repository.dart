
import 'package:dartz/dartz.dart';
import 'package:loging_app/features/product/data/models/product_model.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Stream<Either<Failure, Product>> getProducts();
  Future<Either<Failure, bool>> addProduct(Product product);
  Future<Either<Failure, Product>> getOrderProduct(int idOrder);
  Future<Either<Failure, bool>>  updateProduct(ProductModel updatedProduct);
  Future<Either<Failure, bool>>  deleteProduct(int idProduct);
}
