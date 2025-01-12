part of 'edit_product_bloc.dart';

abstract class EditProductEvent extends Equatable {
  const EditProductEvent();

  @override
  List<Object?> get props => [];
}

class EditProductButtonPressed extends EditProductEvent {
  final ProductModel product;

  const EditProductButtonPressed({required this.product});

  @override
  List<Object?> get props => [product];
}
