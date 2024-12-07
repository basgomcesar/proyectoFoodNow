
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class AddProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddProductButtonPressed extends AddProductEvent {
  final String name;
  final String description;
  final double price; 
  final Uint8List photo; 
  final int availableQuantity;
  final bool disponibility;
  final String category;

  AddProductButtonPressed({
    required this.name,
    required this.description,
    required this.price,
    required this.photo,
    required this.availableQuantity,
    required this.disponibility,
    required this.category
  });

}





