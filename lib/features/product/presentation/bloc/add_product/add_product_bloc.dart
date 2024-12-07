// create_profile_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';
import 'add_product_event.dart';
import 'add_product_state.dart';
import 'package:loging_app/features/product/domain/use_cases/add_product_use_case.dart';


class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProductUseCase addProductUseCase;
  

  AddProductBloc({required this.addProductUseCase})
     : super(AddProductStateInitial()) {
    on<AddProductEvent>((event, emit) async {
      if (event is AddProductButtonPressed) {
        try{
          emit(AddProductStateLoading());
          // Simular un retraso de 2 segundos
          await Future.delayed(const Duration(seconds: 2));
          print('categoria desde bloc: ${event.category}');

          final Product product = Product(
            id: '',
            userId: '',
            name: event.name,
            description: event.description,
            price: event.price,
            photo: event.photo,
            quantityAvailable: event.availableQuantity,
            available: event.disponibility,
            category: event.category,
          );

        final failureOrProduct = await addProductUseCase(product);
           

           failureOrProduct.fold(
            (failure) {
              //Primero es el error
              if (failure is DuplicateProductFailure) {
                emit(DuplicateProductFailureState(error: 'Ya tienes un producto registrado con este nombre')); 

              } else if (failure is InvalidDataFailure) {
                emit(InvalidDataFailureState(error: 'Los datos ingresados son inválidos. Por favor, verifica tus datos.'));

              } else if (failure is InvalidPriceFailure){
                emit(InvalidPriceFailureState(error: 'El precio ingresado es inválido. Debe ser un número con hasta 2 decimales.'));

              } else {
                emit(ServerFailureState(error: 'Ocurrió un error al crear el perfil.'));
              }
            },
            (bool) => emit(AddProductStateSucess()),
            
          );
        } catch (e) {
          emit(AddProdudctStateFailurre(error: 'Error inesperado: ${e.toString()}'));
        }
        
        
      }
    });
  }

}
