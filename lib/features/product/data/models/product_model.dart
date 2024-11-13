import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.available,
    required super.status,
  });

  factory ProductModel.fromGrpc(Product grpcProduct) {
    return ProductModel(
      id: grpcProduct.id,
      name: grpcProduct.name,
      available: grpcProduct.available,
      status: grpcProduct.status,
    );
  }
}
