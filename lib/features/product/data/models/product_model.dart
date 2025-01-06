import 'dart:typed_data';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:loging_app/generated/productos.pb.dart';

import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    super.category,
    required super.available,
    required super.description,
    required super.price,
    required super.quantityAvailable,
    required super.photo,
    required super.userId,
  });

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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      quantityAvailable: json['quantityAvailable'] as int,
      available: json['available'] as bool,
      photo: Uint8List.fromList((json['photo'] as List<dynamic>).cast<int>()),
      userId: json['userId'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': name,
      'categoria': category,
      'descripcion': description,
      'precio': price,
      'cantidadDisponible': quantityAvailable,
      'disponible': available,
      'foto': photo,
      'idUsuario': userId,
    };
  }

  FormData toFormData() {
    return FormData.fromMap({
      'id': id,
      'nombre': name,
      'categoria': category,
      'descripcion': description,
      'precio': price,
      'cantidadDisponible': quantityAvailable,
      'disponible': available,
      'foto': MultipartFile.fromBytes(photo, filename: 'photo.jpg'),
      'idUsuario': userId,
    });
  }

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

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      available: product.available,
      description: product.description,
      price: product.price,
      quantityAvailable: product.quantityAvailable,
      photo: product.photo,
      userId: product.userId,
      category: product.category,
    );
  }

  factory ProductModel.fromJsonEsp(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['idProducto'] as int?)?.toString() ?? '',

      name: json['nombre'] as String? ?? 'Sin nombre',
      
      category: json['categoria'] as String? ?? 'Sin categoría',
      
      description: json['descripcion'] as String? ?? 'Sin descripción',
      
      price: double.tryParse(json['precio'].toString()) ?? 0.0,
      
      quantityAvailable: json['cantidadDisponible'] as int? ?? 0,
      
      available: (json['disponible'] as int?) == 1,
      
      photo: json['foto'] is String
          ? base64Decode(json['foto'] as String)
          : (json['foto'] is Map<String, dynamic> &&
                  json['foto']['data'] is List)
              ? Uint8List.fromList(
                  (json['foto']['data'] as List<dynamic>).cast<int>())
              : Uint8List(0),

      userId: (json['idUsuario'] as int?)?.toString() ?? '',
    );
  }
}
