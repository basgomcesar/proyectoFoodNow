import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/product/domain/use_cases/get_products_offered_use_case.dart';
import '../../../domain/use_cases/get_products.dart';
import '../../../domain/entities/product.dart';

abstract class ProductOfferedState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductOfferedState {}

class ProductLoading extends ProductOfferedState {}

class ProductLoaded extends ProductOfferedState {
  final List<Product> products;
  ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductOfferedState {
  final String message;
  ProductError(this.message);

  @override
  List<Object> get props => [message];
}

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}

class ProductBloc extends Bloc<ProductEvent, ProductOfferedState> {
  final GetProductsOfferedUseCase getProducts;

  ProductBloc({required this.getProducts}) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());

      // Asumiendo que el 'userId' está disponible en algún lugar, aquí lo pasamos
      final result = await getProducts.call('userId'); // Pasa el userId aquí correctamente

      result.fold(
        (failure) => emit(ProductError(failure.message)), // Manejamos el error con el mensaje
        (products) => emit(ProductLoaded(products)), // Emitimos la lista de productos correctamente
      );
    });
  }
}