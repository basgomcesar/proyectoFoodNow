import 'package:equatable/equatable.dart';
import 'package:loging_app/features/product/domain/entities/product_graph.dart';

abstract class ProductOfferedState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductOfferedInitial extends ProductOfferedState {}

class ProductOfferedLoading extends ProductOfferedState {}

class ProductOfferedLoaded extends ProductOfferedState {
  final List<ProductGraph> products;

  ProductOfferedLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductOfferedError extends ProductOfferedState {
  final String message;

  ProductOfferedError(this.message);

  @override
  List<Object> get props => [message];
}