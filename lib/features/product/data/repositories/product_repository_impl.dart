import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../domain/entities/product.dart';
import 'package:loging_app/features/product/data/models/product_model.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';

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

   @override
    Future<Either<Failure, bool>> addProduct(Product product) async {
      try {
        final addedProduct = await remoteDataSource.addProduct(ProductModel.fromEntity(product));
        return Right(addedProduct);

      } on DuplicateProductFailure catch (e) {
        return Left(DuplicateProductFailure(e.message));

      }on InvalidDataFailure catch (e) {
      return Left(InvalidDataFailure(e.message));

      } on InvalidPriceFailure catch (e) {
        return Left(InvalidPriceFailure(e.message));

      } on UnknownFailure catch (e) {
        return Left(UnknownFailure(e.message));

      } catch (e, stackTrace) {
        
        return Left(UnknownFailure('Ocurrió un error inesperado.'));
      }
    }

  }

