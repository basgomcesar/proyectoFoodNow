import 'package:equatable/equatable.dart';

abstract class AddProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddProductStateInitial extends AddProductState {
  
}

class AddProductStateLoading extends AddProductState {
}

class AddProductStateSucess extends AddProductState {
  
}

class AddProdudctStateFailurre extends AddProductState {
  final String error;
  AddProdudctStateFailurre({required this.error});
}
//
class DuplicateProductFailureState extends AddProductState {
  final String error;
  DuplicateProductFailureState({required this.error});
}

class ServerFailureState extends AddProductState {
  final String error;
  ServerFailureState({required this.error});
}

class InvalidDataFailureState extends AddProductState {
  final String error;
  InvalidDataFailureState({required this.error});
}

class InvalidPriceFailureState extends AddProductState {
  final String error;
  InvalidPriceFailureState({required this.error});
}


