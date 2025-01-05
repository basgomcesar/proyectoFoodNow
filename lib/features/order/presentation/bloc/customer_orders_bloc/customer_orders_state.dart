part of 'customer_orders_bloc.dart';

sealed class CustomerOrdersState {
  const CustomerOrdersState();
}

final class CustomerOrdersInitial extends CustomerOrdersState {}

final class CustomerOrdersLoading extends CustomerOrdersState {}

final class CustomerOrdersSuccess extends CustomerOrdersState {
  final List<ProductOrder> orders;
  CustomerOrdersSuccess(this.orders);
}

final class CustomerOrdersFailure extends CustomerOrdersState {
  final String message;
  const CustomerOrdersFailure(this.message);
}