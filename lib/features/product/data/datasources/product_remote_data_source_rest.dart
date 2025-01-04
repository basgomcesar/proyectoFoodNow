import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:loging_app/core/error/failure.dart';
import '../../../../core/utils/session.dart';
import '../../domain/entities/product_graph.dart';

abstract class ProductRemoteDataSourceRest {
  Future<Either<Failure, List<ProductGraph>>> getProductsOffered(String userId, String anio, String mes);
}

class ProductRemoteDataSourceRestImpl implements ProductRemoteDataSourceRest {
  final Dio client = Dio(BaseOptions(
  validateStatus: (status) {
    return status! < 500; // No lanzar excepciones para respuestas con status < 500
  },
));
  final String apiUrl = 'http://localhost:3000'; // URL de tu API
  final Session session = Session.instance;

  ProductRemoteDataSourceRestImpl();

  @override
  Future<Either<Failure, List<ProductGraph>>> getProductsOffered(String userId, String anio, String mes) async {
  try {
    final response = await client.get(
      '$apiUrl/products/statistics/$userId/$anio/$mes',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'x-token': session.token,
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> productList = response.data['productos'];

      final List<ProductGraph> products = productList.map((product) {
        return ProductGraph(
          name: product['producto'], // name
          sales: product['cantidad_vendida'],  // sales
        );
      }).toList();

      return Right(products); // Retorna la lista en caso de éxito
    } else {
      return Left(ServerFailure('Failed to fetch products: ${response.statusCode}'));
    }
  } catch (e) {
    print('Error in getProductsOffered: $e');
    return Left(ServerFailure('Failed to fetch products: $e'));
  }
}

}