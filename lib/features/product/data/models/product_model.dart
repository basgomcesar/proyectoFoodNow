import 'dart:typed_data';

import 'package:loging_app/generated/productos.pb.dart';

import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.available,
    required super.description,
    required super.price,
    required super.quantityAvailable,
    required super.photo,
    required super.userId,
  });

  /// Crea una instancia de `ProductModel` desde una respuesta gRPC
  factory ProductModel.fromGrpc(ProductUpdateResponse product) {
    return ProductModel(
      id: product.productId,
      name: product.productName,
      description: product.description,
      price: product.price,
      quantityAvailable: product.quantityAvailable,
      available: product.available,
      photo: Uint8List.fromList(product.photo),
      userId: product.userId,
    );
  }

  // Método para mapear desde JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      available: json['available'],
      description: json['description'],
      price: json['price'].toDouble(),
      quantityAvailable: json['quantityAvailable'],
      photo: Uint8List.fromList(List<int>.from(json['photo']['data'])),
      userId: json['userId'],
    );
  }

  /// Convierte un `ProductModel` en una entidad del dominio `Product`
  Product toDomain() {
    return Product(
      id: id,
      name: name,
      available: available,
      description: description,
      price: price,
      quantityAvailable: quantityAvailable,
      photo: photo,
      userId: userId,
    );
  }
}
