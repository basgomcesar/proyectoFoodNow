
import 'package:equatable/equatable.dart';

abstract class EditProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EditProfileButtonPressed extends EditProfileEvent {
  final String name;
  final String email;
  final String password;
  final String profileImage;

  EditProfileButtonPressed({
    required this.name,
    required this.email, 
    required this.password,
    required this.profileImage
  });

}


