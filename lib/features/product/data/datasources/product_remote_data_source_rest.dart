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
  final Dio client = Dio();
  final String apiUrl;
  final Session session = Session.instance;
  
  ProductRemoteDataSourceRestImpl({required this.apiUrl});

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
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> productList = response.data['productos'] ?? [];
      if (productList.isEmpty) {
        return Left(ServerFailure('No hay productos para mostrar.'));
      }

      final List<ProductGraph> products = productList.map((product) {
        return ProductGraph(
          name: product['producto'] ?? 'Nombre desconocido',
          sales: product['cantidad_vendida'] ?? 0,
        );
      }).toList();

      return Right(products);
    } else if (response.statusCode == 401) {
      return Left(ServerFailure('No autorizado. Verifica tu token.'));
    } else {
      return Left(ServerFailure('Error al obtener productos: ${response.statusCode}. ${response.data}'));
    }
  } catch (e) {
    print('Error en getProductsOffered: $e');
    return Left(ServerFailure('Error al obtener productos: ${e.toString()}'));
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
  print('Response data: ${response.data}');  // Esto te permitirá ver la estructura real de los datos.

  final List<dynamic> productList = response.data['productos'];
  final List<Product> products = productList.map((product) {
    print('Product data: $product');  // Imprime cada producto para revisar sus datos.
    return Product(
      id: (product['idProducto'] ?? '').toString(),  // Convierte a String si es necesario
      name: (product['producto'] ?? '').toString(),  // Convierte a String si es necesario
      available: product['cantidadDisponible'] > 0,
      category: product['categoria']?.toString(),  // Convierte si es necesario
      description: product['descripcion']?.toString(),
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