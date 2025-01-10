import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';
import 'package:loging_app/features/product/domain/entities/product_graph.dart';
import 'package:loging_app/features/product/domain/repositories/product_rest_repository.dart';

import '../datasources/product_remote_data_source_rest.dart';

class ProductRestRepositoryRestImpl implements ProductRestRepository {
  final ProductRemoteDataSourceRest userRemoteDataSourceRest;

  ProductRestRepositoryRestImpl(this.userRemoteDataSourceRest);

  @override
  Future<Either<Failure, List<ProductGraph>>> getProductsOffered( String anio, String mes) async {
    try {
      final result = await userRemoteDataSourceRest.getProductsOffered( anio, mes);

      return result.fold(
        (failure) {
          return Left(failure); 
        },
        (products) {
          return Right(products); 
        },
      );
    } catch (e) {
      return Left(ServerFailure('Error while fetching products: $e'));
    }
  }

  @override
Future<Either<Failure, List<Product>>> getProductsSeller(String sellerId) async {
  try {
    if (sellerId.isEmpty) {
      return Left(ServerFailure('Seller ID cannot be empty.'));
    }

    final result = await userRemoteDataSourceRest.getProductsSeller(sellerId);

    return result.fold(
      (failure) {
        return Left(failure); 
      },
      (products) {
        return Right(products); 
      },
    );
  } catch (e) {
    return Left(ServerFailure('Error while fetching seller products: $e'));
  }
}
}