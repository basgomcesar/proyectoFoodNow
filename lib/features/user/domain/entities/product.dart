import 'dart:typed_data';

class Product {
  final String name;
  final String description;
  final double price; 
  final Uint8List photo; 
  final int availableQuantity;
  final bool disponibility;
  final String category;
  final int idUser;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.photo,
    required this.availableQuantity,
    required this.disponibility,
    required this.category,
    required this.idUser
  });

}
