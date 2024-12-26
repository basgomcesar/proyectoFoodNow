
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import 'package:loging_app/features/order/domain/use_cases/get_pending_orders.dart';

part 'pending_orders_event.dart';
part 'pending_orders_state.dart';

class PendingOrdersBloc extends Bloc<PendingOrdersEvent, PendingOrdersState> {
  final GetPendingOrders _getPendingOrders;
  PendingOrdersBloc({
    required GetPendingOrders getPendingOrders,}) 
    : _getPendingOrders = getPendingOrders, 
    super(PendingOrdersInitial()) {
    on<OrderGetPendingOrders>((event, emit) async {
      final res = await _getPendingOrders();
      res.fold(
        (l) => emit(PendingOrdersFailure(l.message)), 
        (r) => emit(PendingOrdersSuccess(r)));
    });
  }
}
