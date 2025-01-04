import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/product/domain/entities/product_graph.dart';
import 'package:loging_app/features/product/domain/repositories/product_offered_repository.dart';

import '../datasources/product_remote_data_source_rest.dart';

class ProductOfferedRepositoryRestImpl implements ProductOfferedRepository {
  final ProductRemoteDataSourceRest userRemoteDataSourceRest;

  ProductOfferedRepositoryRestImpl(this.userRemoteDataSourceRest);

  @override
  Future<Either<Failure, List<ProductGraph>>> getProductsOffered(String userId, String anio, String mes) async {
    try {
      // Parámetros fijos para pruebas
      final fixedUserId = '1';
      final fixedAnio = '2024';
      final fixedMes = '12';

      print('UserRepositoryImpl: getProductsOffered');
      print('Año: $fixedAnio');
      print('Mes: $fixedMes');

      print('Fetching products for UserId: $fixedUserId, Año: $fixedAnio, Mes: $fixedMes');

      final result = await userRemoteDataSourceRest.getProductsOffered(fixedUserId, fixedAnio, fixedMes);

      return result.fold(
        (failure) {
          print('Error fetching products: ${failure.toString()}');
          return Left(failure); // Retorna el error
        },
        (products) {
          print('Fetched products: ${products.length} products retrieved');
          return Right(products); // Retorna los productos en caso de éxito
        },
      );
    } catch (e) {
      print('Exception in getProductsOffered: $e');
      return Left(ServerFailure('Error while fetching products: $e'));
    }
  }
}