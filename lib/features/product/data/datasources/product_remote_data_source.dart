import 'package:loging_app/features/product/domain/entities/product.dart';

import '../models/product_model.dart';
import 'package:grpc/grpc.dart';
import '../../../../generated/productos.pbgrpc.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {

  final ClientChannel channel;
  late final ProductServiceClient client;

  ProductRemoteDataSourceImpl(this.channel) {
    client = ProductServiceClient(channel);
  }
  

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      print('Getting products from server');
      final request = ProductUpdateRequest();
      final responseStream = client.subscribeToProductUpdates(request);

      final products = <ProductModel>[];
      await for (var product in responseStream) {
      print('Received product: ${product.description}');
      products.add(ProductModel.fromGrpc(product as Product));
      }
      return products;
    } catch (e) {
      print('Error getting products: $e');
      rethrow;
    }
  }
}
