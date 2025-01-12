part of 'edit_product_bloc.dart';

abstract class EditProductState extends Equatable {
  const EditProductState();

  @override
  List<Object?> get props => [];
}

class EditProductInitialState extends EditProductState {}

class EditProductLoadingState extends EditProductState {}

class EditProductSuccessState extends EditProductState {}

class EditProductFailureState extends EditProductState {
  final String error;

  const EditProductFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
