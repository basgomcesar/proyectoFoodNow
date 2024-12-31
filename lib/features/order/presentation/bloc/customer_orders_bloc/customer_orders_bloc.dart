import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import 'package:loging_app/features/order/domain/use_cases/get_customer_orders.dart';

part 'customer_orders_event.dart';
part 'customer_orders_state.dart';

class CustomerOrdersBloc extends Bloc<CustomerOrdersEvent, CustomerOrdersState> {
  final GetCustomerOrders _getCustomerOrders;
  CustomerOrdersBloc({
    required GetCustomerOrders getCustomerOrders,}) 
    : _getCustomerOrders = getCustomerOrders, 
    super(CustomerOrdersInitial()) {
    on<CustomerGetCustomerOrders>((event, emit) async {
      final res = await _getCustomerOrders();
      res.fold(
        (l) => emit(CustomerOrdersFailure(l.message)), 
        (r) => emit(CustomerOrdersSuccess(r)));
    });
  }
}
