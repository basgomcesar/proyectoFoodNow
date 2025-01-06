import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:loging_app/core/error/failure.dart';
import '../../../../core/utils/session.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_graph.dart';
import 'dart:typed_data';

abstract class ProductRemoteDataSourceRest {
  Future<Either<Failure, List<ProductGraph>>> getProductsOffered(String userId, String anio, String mes);
  Future<Either<Failure, List<Product>>> getProductsSeller(String sellerId);
}

class ProductRemoteDataSourceRestImpl implements ProductRemoteDataSourceRest {
  final Dio client = Dio(BaseOptions(
  validateStatus: (status) {
    return status! < 500; 
  },
));
  final String apiUrl = 'http://localhost:3000'; 
  final Session session = Session.instance;

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
          name: product['producto'],
          sales: product['cantidad_vendida'],
        );
      }).toList();

      return Right(products); 
    } else {
      return Left(ServerFailure('Failed to fetch products: ${response.statusCode}'));
    }
  } catch (e) {
    print('Error in getProductsOffered: $e');
    return Left(ServerFailure('Failed to fetch products: $e'));
  }
}

  
@override
Future<Either<Failure, List<Product>>> getProductsSeller(String sellerId) async {
  try {
    final response = await client.get(
      '$apiUrl/products/offered/$sellerId',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'x-token': session.token, 
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> productList = response.data['productos'];

      final List<Product> products = productList.map((product) {
        return Product(
          id: product['idProducto'] ?? '', 
          name: product['producto'] ?? '', 
          category: product['categoria'], 
          available: product['cantidadDisponible'] > 0, 
          description: product['descripcion'] ?? '', 
          price: double.tryParse(product['precio'].toString()) ?? 0.0, 
          quantityAvailable: product['cantidadDisponible'] ?? 0,
          photo: Uint8List(0), 
          userId: sellerId, 
        );
      }).toList();

      return Right(products); 
    } else {
      return Left(ServerFailure(
          'Failed to fetch seller products: ${response.statusCode} - ${response.statusMessage}'));
    }
  } catch (e) {
    print('Error in getProductsSeller: $e');
    return Left(ServerFailure('Failed to fetch seller products: $e'));
  }
}
}