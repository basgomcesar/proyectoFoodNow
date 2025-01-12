import 'package:equatable/equatable.dart';

abstract class ProductOfferedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProductsOffered extends ProductOfferedEvent {
  final String anio;
  final String mes;

  FetchProductsOffered({
    required this.anio,
    required this.mes});

  @override
  List<Object> get props => [ anio, mes];
}
