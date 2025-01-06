import 'dart:typed_data';

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

  /// Crea una instancia de `ProductModel` desde un JSON
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

  /// Convierte un `ProductModel` en un mapa JSON
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

  /// Convierte un `ProductModel` en un `FormData`
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

  /// Crea una instancia de `ProductModel` desde una entidad del dominio `Product`
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
      id: (json['idProducto'] as int?)?.toString() ??
          '', // 'idProducto' es int en la API, lo convertimos a String
      name: json['nombre'] as String? ??
          'Sin nombre', // 'nombre' en la API -> 'name' en el modelo
      category: json['categoria'] as String? ??
          'Sin categoría', // 'categoria' en la API -> 'category' en el modelo
      description: json['descripcion'] as String? ??
          'Sin descripción', // 'descripcion' en la API -> 'description' en el modelo
      price: double.tryParse(json['precio'].toString()) ??
          0.0, // Convertir 'precio' de String a double
      quantityAvailable: json['cantidadDisponible'] as int? ??
          0, // 'cantidadDisponible' en la API -> 'quantityAvailable' en el modelo
      available: (json['disponible'] as int?) ==
          1, // 'disponible' en la API es int (1 o 0) -> bool
      // Manejar foto como un String (por ejemplo, URL) o como una lista de enteros (por ejemplo, base64)
      photo: json['foto'] is String
          ? Uint8List(
              0) // Si 'foto' es un String, asigna un valor predeterminado vacío
          : (json['foto'] as List<dynamic>?)?.cast<int>().isNotEmpty ?? false
              ? Uint8List.fromList((json['foto'] as List<dynamic>).cast<int>())
              : Uint8List(
                  0), // Si 'foto' es una lista de enteros, conviértelo a Uint8List
      userId: (json['idUsuario'] as int?)?.toString() ??
          '', // 'idUsuario' es int en la API, lo convertimos a String
    );
  }
}
