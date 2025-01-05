part of 'customer_orders_bloc.dart';

@immutable
sealed class CustomerOrdersEvent {}

final class CustomerGetCustomerOrders extends CustomerOrdersEvent {}
