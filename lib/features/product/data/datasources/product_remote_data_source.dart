import 'package:loging_app/features/product/domain/entities/product.dart';

import '../models/product_model.dart';
import '../../../../generated/productos.pbgrpc.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ProductServiceClient client;

  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductModel>> getProducts() async {
    final request = ProductUpdateRequest();
    final responseStream = client.subscribeToProductUpdates(request);

    final products = <ProductModel>[];
    await for (var product in responseStream) {
      products.add(ProductModel.fromGrpc(product as Product));
    }
    return products;
  }
}
