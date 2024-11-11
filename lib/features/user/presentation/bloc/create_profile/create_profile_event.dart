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
  final String profileImage;
  final bool disponibility;

  CreateProfileButtonPressed({
    required this.name,
    required this.email, 
    required this.password,
    required this.userType, 
    required this.profileImage,
    required this.disponibility  
  });

}


