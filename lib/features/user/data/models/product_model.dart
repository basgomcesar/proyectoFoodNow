import 'package:loging_app/features/user/domain/entities/product.dart';

class ProductModel extends Product {
  // Constructor modificado para que reciba los parámetros directamente
  ProductModel({
    required super.name,
    required super.description,
    required super.price,
    required super.photo,
    required super.availableQuantity,
    required super.category,
    required super.disponibility,
    required super.idUser,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      photo: json['photo'],
      availableQuantity: json['availableQuantity'],
      category: json['category'],
      disponibility: json['disponibility'],
      idUser: json['idUser'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'photo': photo,
      'availableQuantity': availableQuantity,
      'category': category,
      'disponibility': disponibility,
      'idUser': idUser,
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      name: product.name,
      description: product.description,
      price: product.price,
      photo: product.photo,
      availableQuantity: product.availableQuantity,
      category: product.category,
      disponibility: product.disponibility,
      idUser: product.idUser,
    );
  }

  get id => null;
  
}
