import 'package:equatable/equatable.dart';

import '../../../domain/entities/product.dart';

abstract class ProductsSellerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsSellerInitial extends ProductsSellerState {}

class ProductsSellerLoading extends ProductsSellerState {}

class ProductsSellerLoaded extends ProductsSellerState {
  final List<Product> products;

  ProductsSellerLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductsSellerError extends ProductsSellerState {
  final String message;

  ProductsSellerError(this.message);

  @override
  List<Object?> get props => [message];
}
