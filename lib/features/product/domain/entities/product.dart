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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      available: json['available'] as bool,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      quantityAvailable: json['quantityAvailable'] as int,
      photo: base64Decode(json['photo'] as String),
      userId: json['userId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'available': available,
      'description': description,
      'price': price,
      'quantityAvailable': quantityAvailable,
      'photo': base64Encode(photo),
      'userId': userId,
    };
  }
}