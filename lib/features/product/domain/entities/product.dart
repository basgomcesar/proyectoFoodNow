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
  final String userId;

  Product({
    required this.id,
    required this.name,
    this.category,
    required this.available,
    this.description,
    required this.price,
    required this.quantityAvailable,
    required this.photo,
    required this.userId,
  });
}
