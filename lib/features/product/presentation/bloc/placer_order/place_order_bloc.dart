import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';
import 'package:loging_app/features/product/domain/entities/product_order.dart';
import 'package:loging_app/features/product/domain/use_cases/place_order_use_case.dart';
import 'package:loging_app/features/product/presentation/bloc/placer_order/place_order_event.dart';
import 'package:loging_app/features/product/presentation/bloc/placer_order/place_order_state.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  final PlaceOrderUseCase placeOrderUseCase;

  PlaceOrderBloc(this.placeOrderUseCase) : super(PlaceOrderInitial()) {
    on<PlaceOrderEvent>((event, emit) async {
      if (event is PlaceOrder) {
        try {
          // Emitimos un estado inicial (opcional)
          emit(PlaceOrderInitial());

          // Llamamos al caso de uso para procesar el pedido
          final Either<Failure, ProductOrder> failureOrOrder =
              await placeOrderUseCase(event.product, event.quantity);

          // Procesamos la respuesta del caso de uso
          failureOrOrder.fold(
            (failure) {
              // Emitimos un error si el caso de uso falla
              if (failure is InvalidDataFailure) {
                emit(PlaceOrderError(
                    "Datos inválidos. Por favor, revisa tu pedido."));
              } else if (failure is NetworkFailure) {
                emit(PlaceOrderError(
                    "Error de red, intenta de nuevo más tarde."));
              } else {
                emit(PlaceOrderError(
                    "Ocurrió un error al procesar el pedido."));
              }
            },
            (order) {
              // Emitimos el estado de "espera" cuando se recibe el ProductOrder
              emit(PlaceOrderWaiting(order: order));
            },
          );
        } catch (e) {
          // Capturamos errores inesperados
          emit(PlaceOrderError("Error inesperado: ${e.toString()}"));
        }
      } else if (event is CancelOrder) {
        // Emitimos el estado de pedido cancelado
        emit(PlaceOrderCanceled());
      } else if (event is OrderDelivered) {
        // Emitimos el estado de pedido entregado
        emit(PlaceOrderDelivered());
      }
    });
  }
}
