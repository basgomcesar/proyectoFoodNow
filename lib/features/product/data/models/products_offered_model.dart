import '../../domain/entities/product.dart';

class ProductsOfferedModel extends Product {
  ProductsOfferedModel({
    required super.id,
    required super.name,
    required super.description, 
    required super.price,
    required super.quantityAvailable,
    required super.available,
    required super.photo, 
    required super.userId
  });

  factory ProductsOfferedModel.fromJson(Map<String, dynamic> json) {
    return ProductsOfferedModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      quantityAvailable: json['quantityAvailable'],
      available: json['available'], 
      photo: json['photo'],
      userId: json['userId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantityAvailable': quantityAvailable,
      'available': available,
      'photo': photo,
      'userId': userId,
    };
  }

  factory ProductsOfferedModel.fromEntity(Product product) {
    return ProductsOfferedModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      quantityAvailable: product.quantityAvailable,
      available: product.available,
      photo: product.photo,
      userId: product.userId
    );
  }
}