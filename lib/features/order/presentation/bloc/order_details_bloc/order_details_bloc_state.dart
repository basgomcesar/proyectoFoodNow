part of 'order_details_bloc.dart';

@immutable
sealed class OrderDetailsBlocState {
  const OrderDetailsBlocState();
}

final class OrderDetailsBlocInitial extends OrderDetailsBlocState {}

final class OrderDetailsLoading extends OrderDetailsBlocState {}

final class OrderDetailsSuccess extends OrderDetailsBlocState {
  final Product product;
  const OrderDetailsSuccess(this.product);
}

final class OrderDetailsFailure extends OrderDetailsBlocState {
  final String message;
  const OrderDetailsFailure(this.message);
}
