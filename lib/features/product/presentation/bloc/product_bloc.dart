import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_products.dart';
import '../../domain/entities/product.dart';

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
            products.add(product);
            emit(ProductLoaded(List.unmodifiable(products)));
          },
        );
      }
    });
  }
}
