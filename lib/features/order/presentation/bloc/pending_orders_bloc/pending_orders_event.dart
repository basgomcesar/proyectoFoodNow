part of 'pending_orders_bloc.dart';

@immutable
sealed class PendingOrdersEvent {}

final class OrderGetPendingOrders extends PendingOrdersEvent {}
