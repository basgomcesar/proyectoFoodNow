import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_products_seller_use_case.dart';
import 'products_seller_event.dart';
import 'products_seller_state.dart';

class ProductsSellerBloc extends Bloc<ProductsSellerEvent, ProductsSellerState> {
  final GetProductsSellerUseCase getProductsSellerUseCase;

  ProductsSellerBloc({required this.getProductsSellerUseCase})
      : super(ProductsSellerInitial()) {
    on<FetchProductsSeller>((event, emit) async {
      emit(ProductsSellerLoading());

      try {
        final result = await getProductsSellerUseCase.call(event.sellerId);

        result.fold(
          (failure) => emit(ProductsSellerError(failure.message)),
          (products) => emit(ProductsSellerLoaded(products)),
        );
      } catch (e) {
        emit(ProductsSellerError("Unexpected error: $e"));
      }
    });
  }
}
