import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_products.dart';
import '../../domain/entities/product.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);
}
class ProductError extends ProductState {}

class ProductEvent extends Equatable{
  @override
  // TODO: implement props
   List<Object> get props => [];
  
}

class FetchProducts extends ProductEvent {}

class ProductBloc extends Bloc<ProductEvent,ProductState> {
  final GetProducts getProducts;

  ProductBloc({required this.getProducts}) : super(ProductInitial()){
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      final result = await getProducts();
      result.fold(
        (failure) => emit(ProductError()),
        (products) => emit(ProductLoaded(products)),
      );
    });
  }

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    final result = await getProducts();
    result.fold(
      (failure) => emit(ProductError()),
      (products) => emit(ProductLoaded(products)),
    );
  }
}
