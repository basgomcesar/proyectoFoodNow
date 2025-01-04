import 'dart:convert';
import 'dart:typed_data';

class Product {
  final String id;
  final String name;
  final String? category;
  final bool available;
  final String? description;
  final double price;
  final int quantityAvailable;
  final Uint8List photo;
  final String? userId;

  Product({
    required this.id,
    required this.name,
    this.category,
    required this.available,
    this.description,
    required this.price,
    required this.quantityAvailable,
    required this.photo,
    this.userId,
  });

  /// Factory constructor for creating a `Product` instance from a JSON map.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String?,
      available: json['available'] as bool,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      quantityAvailable: json['quantityAvailable'] as int,
      photo: base64Decode(json['photo'] as String),
      userId: json['userId'] as String?,
    );
  }

  /// Converts the `Product` instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'available': available,
      'description': description,
      'price': price,
      'quantityAvailable': quantityAvailable,
      'photo': base64Encode(photo),
      'userId': userId,
    };
  }

  /// Factory constructor for creating a `Product` instance from a Dart map.
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      category: map['category'] as String?,
      available: map['available'] as bool,
      description: map['description'] as String?,
      price: (map['price'] as num).toDouble(),
      quantityAvailable: map['quantityAvailable'] as int,
      photo: map['photo'] as Uint8List,
      userId: map['userId'] as String?,
    );
  }

  /// Converts the `Product` instance to a Dart map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'available': available,
      'description': description,
      'price': price,
      'quantityAvailable': quantityAvailable,
      'photo': photo,
      'userId': userId,
    };
  }
}
