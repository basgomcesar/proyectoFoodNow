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
    return status! < 500; // No lanzar excepciones para respuestas con status < 500
  },
));
  final String apiUrl ; // URL de tu API
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

  @override
Future<Either<Failure, List<Product>>> getProductsSeller(String sellerId) async {
  final int idSeller = 1;
  try {
    final response = await client.get(
      '$apiUrl/products/offered/$idSeller',  // Usamos sellerId en la URL
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'x-token': session.token,  // Usamos el token de sesión para la autenticación
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> productList = response.data['productos'];

      final List<Product> products = productList.map((product) {
        return Product(
          id: product['producto'],  // id del producto
          name: product['producto'],  // nombre del producto
          available: product['disponible'] == 1,  // disponibilidad
          description: product['descripcion'],  // descripción del producto
          price: double.parse(product['precio']),  // precio
          quantityAvailable: product['cantidadDisponible'],  // cantidad disponible
          photo: product['foto'] != null ? Uint8List.fromList([]) : Uint8List(0),  // foto (si es null, asignamos un array vacío)
          userId: null,  // Puedes asignar null o cualquier valor que no necesite pasar el userId
        );
      }).toList();

      return Right(products);  // Retorna la lista de productos
    } else {
      return Left(ServerFailure('Failed to fetch seller products: ${response.statusCode}'));
    }
  } catch (e) {
    print('Error in getProductsSeller: $e');
    return Left(ServerFailure('Failed to fetch seller products: $e'));
  }
}


}