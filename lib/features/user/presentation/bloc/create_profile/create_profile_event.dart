
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class CreateProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateProfileButtonPressed extends CreateProfileEvent {
  final String name;
  final String email;
  final String password;
  final String userType;
  final Uint8List photo;
  final bool disponibility;
  final String location;

  CreateProfileButtonPressed({
    required this.name,
    required this.email, 
    required this.password,
    required this.userType, 
    required this.photo,
    required this.disponibility,  
    required this.location
  });

}


