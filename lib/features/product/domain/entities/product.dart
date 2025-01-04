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
      id: json['producto'] as String, 
      name: json['producto'] as String,
      available: json['cantidadDisponible'] > 0, 
      category: json['categoria'] as String?, 
      description: null, 
      price: 0.0, 
      quantityAvailable: json['cantidadDisponible'] as int, 
      photo: Uint8List(0),
      userId: null,
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