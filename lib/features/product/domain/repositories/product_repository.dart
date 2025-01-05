
import 'package:dartz/dartz.dart';
import 'package:loging_app/features/product/domain/entities/product_order.dart';
import 'package:loging_app/features/product/presentation/bloc/add_product/add_product_bloc.dart';
import 'package:loging_app/features/product/data/models/product_model.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Stream<Either<Failure, Product>> getProducts();
  Future<Either<Failure, bool>> addProduct(Product product);  
  Future<Either<Failure, ProductOrder>> placeOrder(Product product, int quantity);

  Future<Either<Failure, Product>> getOrderProduct(int idOrder);
  Future<Either<Failure, bool>>  updateProduct(ProductModel updatedProduct);
  Future<Either<Failure, bool>>  deleteProduct(int idProduct);
}
