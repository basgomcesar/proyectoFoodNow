import 'package:dartz/dartz.dart';
import 'package:loging_app/features/user/presentation/bloc/add_product/add_product_bloc.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Stream<Either<Failure, Product>> getProducts();
  Stream<Either<Failure, bool>> addProduct();

}
