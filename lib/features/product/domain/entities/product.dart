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
    id: (json['idProducto'] ?? '').toString(),  // Convierte a String
    name: (json['producto'] ?? '').toString(),  // Convierte a String
    available: json['cantidadDisponible'] > 0, 
    category: json['categoria']?.toString(),    // Convierte si es necesario
    description: json['descripcion']?.toString(),
    price: double.tryParse(json['precio'].toString()) ?? 0.0, 
    quantityAvailable: json['cantidadDisponible'] ?? 0,
    photo: Uint8List(0),
    userId: null,
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

  factory Product.fromMap(Map<String, dynamic> map) {
  return Product(
    id: map['id']?.toString() ?? '',  // Convierte el ID a String
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
