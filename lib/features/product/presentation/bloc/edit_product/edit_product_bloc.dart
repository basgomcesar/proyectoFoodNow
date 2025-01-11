import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/product/data/models/product_model.dart';
import 'package:loging_app/features/product/domain/use_cases/update_product_use_case.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  final UpdateProductUseCase updateProductUseCase;

  EditProductBloc({required this.updateProductUseCase}) : super(EditProductInitialState()) {
    on<EditProductButtonPressed>(_onEditProductButtonPressed);
  }

  Future<void> _onEditProductButtonPressed(
      EditProductButtonPressed event, Emitter<EditProductState> emit) async {
    emit(EditProductLoadingState());
    final result = await updateProductUseCase(event.product);
    result.fold(
      (failure) {
        String errorMessage = _mapFailureToMessage(failure);
        emit(EditProductFailureState(error: errorMessage));
      },
      (success) {
        emit(EditProductSuccessState());
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'Error de red. Por favor, verifica tu conexión a internet.';
    } else if (failure is ServerFailure) {
      return 'Error en el servidor. Por favor, intenta más tarde.';
    } else {
      return 'Ocurrió un error desconocido.';
    }
  }
}
