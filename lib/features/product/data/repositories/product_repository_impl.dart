import 'package:dartz/dartz.dart';
import 'package:loging_app/features/product/data/models/product_model.dart';
import 'package:loging_app/features/product/data/models/products_offered_model.dart';
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
  
  @override
  Future<Either<Failure, List<Product>>> getProductsOffered(String userId) async {
    try {
      print('ProductRepositoryImpl: getProductsOffered');
      print('userId: $userId');
      final List<Product> products = await remoteDataSource.getProductsOffered(userId); // Llama al servidor
      print('Productos obtenidos correctamente: $products');
      return Right(products); // Devuelve la lista de productos en caso de éxito
    } catch (e) {
      print('Error en getProductsOffered en ProductRepositoryImpl: $e');
      return Left(ServerFailure('Failed to fetch products')); // Devuelve un fallo en caso de error
    }
  }
 
 


  /*
  @override
  Future<Either<Failure, List<Product>>> getProductsOffered(String userId) async {
    try {
      final List<Product> products = await remoteDataSource.getProductsOffered(userId);
      print('Productos obtenidos correctamente del datasource');
      return Right(products);
    } catch (e) {
      print('Error en getProductsOffered en UserRepositoryImpl: $e');
      return Left(ServerFailure('Failed to fetch products'));
    }
  }
  */
  
  
}
