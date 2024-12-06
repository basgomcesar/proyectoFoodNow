// core/utils/routes.dart
import 'package:flutter/material.dart';
import 'package:loging_app/features/order/presentation/screens/detallespedidoscreen.dart';
import 'package:loging_app/features/user/presentation/screens/HomeScreen.dart';
import 'package:loging_app/features/user/presentation/screens/LoginScreen.dart';
import 'package:loging_app/features/user/presentation/screens/CreateProfile.dart';
import 'package:loging_app/features/user/presentation/screens/EditProfile.dart';
import 'package:loging_app/features/order/presentation/screens/pedidosaentregarscreen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String createProfile = '/createProfile';
  static const String home = '/home';
  static const String editProfile = '/editProfile';
  static const String pedidosEntrega = '/pedidosparaentregar';
  static const String detallesPedido = '/detallespedido';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      createProfile: (context) => const CreateProfile(),
      home: (context) => const HomeScreen(email: '',),
      editProfile: (context) => const EditProfile(),
      pedidosEntrega : (context) => const Pedidosaentregarscreen(),
    };
  }
}
