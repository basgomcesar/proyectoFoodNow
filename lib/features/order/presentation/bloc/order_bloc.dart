
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/order/domain/use_cases/get_pending_orders.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetPendingOrders _getPendingOrders;
  OrderBloc({
    required GetPendingOrders getPendingOrders,}) 
    : _getPendingOrders = getPendingOrders, 
    super(OrderInitial()) {
    on<OrderGetPendingOrders>((event, emit){
      _getPendingOrders();
    });
  }
}
