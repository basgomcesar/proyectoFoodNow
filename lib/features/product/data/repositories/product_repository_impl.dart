import 'package:dartz/dartz.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../../../core/error/failure.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

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
        print(stackTrace);
        return Left(UnknownFailure('Ocurrió un error inesperado.'));
      }
    }
    
    @override
    Future<Either<Failure, Product>> getOrderProduct(int idPedido) async {
      try {
        final product = await remoteDataSource.getOrderProduct(idPedido);
        return Right(product);
      } on NotFoundFailure catch (e) {
        return Left(NotFoundFailure(e.message));
      } on ServerFailure catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(UnknownFailure('Ocurrió un error inesperado al obtener el producto del pedido.'));
      }
    }
    
    @override
    Future<Either<Failure, bool>>  deleteProduct(int idProduct) async{
      try {
        final product = await remoteDataSource.deleteProduct(idProduct);
        return Right(product);
      } on NotFoundFailure catch (e) {
        return Left(NotFoundFailure(e.message));
      } on ServerFailure catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(UnknownFailure('Ocurrió un error inesperado al obtener el producto del pedido.'));
      }
    }
    
      @override
      Future<Either<Failure, bool>>  updateProduct(ProductModel updatedProduct) async{
      try {
          final product = await remoteDataSource.updateProduct(updatedProduct);
          return Right(product);
        } on NotFoundFailure catch (e) {
          return Left(NotFoundFailure(e.message));
        } on ServerFailure catch (e) {
          return Left(ServerFailure(e.message));
        } catch (e) {
          return Left(UnknownFailure('Ocurrió un error inesperado al obtener el producto del pedido.'));
        }
    }


  }

