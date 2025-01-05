import 'package:equatable/equatable.dart';
import 'package:loging_app/features/product/domain/entities/product_order.dart';

abstract class PlaceOrderState extends Equatable {
  @override
  List<Object> get props => [];
}

//1. Estado inicial
class PlaceOrderInitial extends PlaceOrderState {}

//2. Esperando entrega del producto
class PlaceOrderWaiting extends PlaceOrderState {
  final ProductOrder order;

  PlaceOrderWaiting({required this.order});
}

//3. Pedido entregado
class PlaceOrderDelivered extends PlaceOrderState {}

//4. Error en la entrega del pedido
class PlaceOrderError extends PlaceOrderState {
  final String message;

  PlaceOrderError(this.message);

  @override
  List<Object> get props => [message];
}

//5. Producto cancelado
class PlaceOrderCanceled extends PlaceOrderState {}
