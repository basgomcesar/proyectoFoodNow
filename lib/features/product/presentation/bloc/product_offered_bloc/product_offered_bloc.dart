import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_products_offered_use_case.dart';
import 'product_offered_event.dart';
import 'product_offered_state.dart';

class ProductOfferedBloc extends Bloc<ProductOfferedEvent, ProductOfferedState> {
  final GetProductsOfferedUseCase getProductsOfferedUseCase;

  ProductOfferedBloc({required this.getProductsOfferedUseCase}) : super(ProductOfferedInitial()) {
    on<FetchProductsOffered>((event, emit) async {
      print('Despachando FetchProductsOffered...');
      emit(ProductOfferedLoading());

      try {
        // Ejecutar el use case
        final result = await getProductsOfferedUseCase(event.userId, event.anio, event.mes);

        // Verificar el resultado (Either<Failure, List<ProductGraph>>)
        result.fold(
          (failure) {
            // Si es un error (Left), emitir el estado de error
            print('Error fetching products: $failure');
            emit(ProductOfferedError('Error fetching products: $failure'));
          },
          (products) {
            // Si es exitoso (Right), emitir los productos
            emit(ProductOfferedLoaded(products));
          },
        );
      } catch (e) {
        // En caso de error inesperado
        print('Unexpected error: $e');
        emit(ProductOfferedError('Unexpected error: $e'));
      }
    });
  }
}
