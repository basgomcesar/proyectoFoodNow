import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_products_offered_use_case.dart';
import 'product_offered_event.dart';
import 'product_offered_state.dart';

class ProductOfferedBloc extends Bloc<ProductOfferedEvent, ProductOfferedState> {
  final GetProductsOfferedUseCase getProductsOfferedUseCase;

  ProductOfferedBloc({required this.getProductsOfferedUseCase})
      : super(ProductOfferedInitial()) {
    on<FetchProductsOffered>((event, emit) async {
      emit(ProductOfferedLoading());

      try {
        final result = await getProductsOfferedUseCase.call(
            event.userId, event.anio, event.mes);

        result.fold(
          (failure) => emit(ProductOfferedError('Error fetching products: $failure')),
          (products) => emit(ProductOfferedLoaded(products)),
        );
      } catch (e) {
        emit(ProductOfferedError('Unexpected error: $e'));
      }
    });
  }
}
