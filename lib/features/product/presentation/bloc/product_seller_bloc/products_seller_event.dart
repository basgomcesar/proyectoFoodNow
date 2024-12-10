import 'package:equatable/equatable.dart';

abstract class ProductsSellerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProductsSeller extends ProductsSellerEvent {
  final String sellerId;

  FetchProductsSeller(this.sellerId);

  @override
  List<Object?> get props => [sellerId];
}
