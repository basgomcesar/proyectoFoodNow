import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_products.dart';
import '../../domain/entities/product.dart';

extension ListExtensions<T> on List<T> {
  void replaceOrRemoveWhere(
      bool Function(T) test, bool Function(T) shouldRemove, T newValue) {
    for (int i = 0; i < length; i++) {
      if (test(this[i])) {
        if (shouldRemove(this[i])) {
          removeAt(i);
        } else {
          this[i] = newValue;
        }
        return;
      }
    }
    if (!shouldRemove(newValue)) {
      add(newValue);
    }
  }
}

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}
class ProductError extends ProductState {}

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc({required this.getProducts}) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      final List<Product> products = [];
      await for (final result in getProducts()) {
        print('Result: $result');
        result.fold(
          (failure) => emit(ProductError()),
          (product) {
            products.replaceOrRemoveWhere(
              (element) => element.id == product.id,
              (element) => product.available == false,
              product,
            );
            emit(ProductLoaded(List.unmodifiable(products)));
          },
        );
      }
    });
  }
}
