part of 'order_details_bloc.dart';

@immutable
sealed class OrderDetailsBlocEvent {}

final class GetOrderDetails extends OrderDetailsBlocEvent {
  final int idPedido;

  GetOrderDetails(this.idPedido);
}
