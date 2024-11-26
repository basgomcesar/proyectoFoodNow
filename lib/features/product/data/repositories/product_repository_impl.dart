import 'package:dartz/dartz.dart';
import 'package:loging_app/features/product/data/models/product_model.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../../../core/error/failure.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Stream<Either<Failure, Product>> getProducts() async* {
    try {
      await for (final product in remoteDataSource.getProducts()) {
        print("product in the repo $product");
        yield Right(product.toDomain());
      }
    } catch (e) {
      yield Left(ServerFailure('An error occurred while fetching products'));
    }
  }
}
