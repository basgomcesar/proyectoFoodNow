part of 'pending_orders_bloc.dart';

sealed class PendingOrdersState {
  const PendingOrdersState();
}

final class PendingOrdersInitial extends PendingOrdersState {}

final class PendingOrdersLoading extends PendingOrdersState {}

final class PendingOrdersSuccess extends PendingOrdersState {
  final List<ProductOrder> orders;
  PendingOrdersSuccess(this.orders);
}

final class PendingOrdersFailure extends PendingOrdersState {
  final String message;
  const PendingOrdersFailure(this.message);
}