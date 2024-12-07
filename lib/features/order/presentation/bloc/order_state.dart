part of 'order_bloc.dart';

sealed class OrderState {
}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderSuccess extends OrderState {}

final class OrderFailure extends OrderState {}
