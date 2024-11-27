import 'package:dio/dio.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';
import 'package:loging_app/features/product/domain/use_cases/get_products_offered_use_case.dart';
import 'package:loging_app/features/product/presentation/screens/productDetailView.dart';

import '../../../../core/utils/session.dart';
import '../models/product_model.dart';
import 'package:grpc/grpc.dart';
import '../../../../generated/productos.pbgrpc.dart';

abstract class ProductRemoteDataSource {
  Stream<ProductModel> getProducts();
  Future<List<ProductModel>> getProductsOffered(String userId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {

  final Dio productsSeller = Dio();
  // Eliminar la referencia a FirebaseFirestore
  final String apiUrl = 'http://localhost:3000'; // URL de tu API
  final Session session = Session.instance;

  final ClientChannel channel;
  late final ProductServiceClient client;

  ProductRemoteDataSourceImpl(this.channel) {
    client = ProductServiceClient(channel);
  }
  
  @override
  Stream<ProductModel> getProducts() async* {
    try {
      print('Getting products from server');
      final request = ProductUpdateRequest();
      final responseStream = client.subscribeToProductUpdates(request);
      await for (var product in responseStream) {
        yield ProductModel.fromGrpc(product);
      }
    } catch (e) {
      print('Error getting products: $e');
      rethrow;
    }
  }
  
  @override
  Future<List<ProductModel>> getProductsOffered(String userId) async {
    try {
      final response = await productsSeller.get(
        '$apiUrl/products/$userId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-token': session.token, // Token de autorización
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data as List<dynamic>;
        return productsJson
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}