import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';
import 'package:loging_app/features/product/domain/use_cases/get_order_product.dart';

part 'order_details_bloc_event.dart';
part 'order_details_bloc_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsBlocEvent, OrderDetailsBlocState> {
  final GetOrderProduct _getOrderProduct;

  OrderDetailsBloc({
    required GetOrderProduct getOrderProduct,
  })  : _getOrderProduct = getOrderProduct,
        super(OrderDetailsBlocInitial()) {
    on<GetOrderDetails>((event, emit) async {
      emit(OrderDetailsLoading()); // Emitimos el estado de carga

      final res = await _getOrderProduct(event.idPedido); // Usamos el ID del pedido del evento

      res.fold(
        (failure) => emit(OrderDetailsFailure(failure.message)), // Si hay un error, emitimos OrderDetailsFailure
        (product) => emit(OrderDetailsSuccess(product)), // Si es exitoso, emitimos OrderDetailsSuccess con el producto
      );
    });
  }
}
