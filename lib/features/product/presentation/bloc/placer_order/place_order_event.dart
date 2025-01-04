
import 'package:equatable/equatable.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';

abstract class PlaceOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlaceOrder extends PlaceOrderEvent {
  final Product product;
  final int quantity;

  PlaceOrder(this.product, this.quantity);

  @override
  List<Object> get props => [product, quantity];
}

class CancelOrder extends PlaceOrderEvent {}

class OrderDelivered extends PlaceOrderEvent {}
