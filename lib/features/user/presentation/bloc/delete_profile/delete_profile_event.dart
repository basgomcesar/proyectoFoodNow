
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class DeleteProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteProfileButtonPressed extends DeleteProfileEvent {  

  DeleteProfileButtonPressed();
}


