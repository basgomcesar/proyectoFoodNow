// core/utils/routes.dart
import 'package:flutter/material.dart';
import 'package:loging_app/features/user/presentation/screens/HomeScreen.dart';
import 'package:loging_app/features/user/presentation/screens/LoginScreen.dart';
import 'package:loging_app/features/user/presentation/screens/CreateProfileScreen.dart';
import 'package:loging_app/features/user/presentation/screens/EditProfileScreen.dart';
import 'package:loging_app/features/product/presentation/screens/AddProductScreen.dart';

import '../../features/order/presentation/screens/PendingOrdersScreen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String createProfile = '/createProfile';
  static const String home = '/home';
  static const String editProfile = '/editProfile';
  static const String pedidosEntrega = '/pedidosparaentregar';
  static const String detallesPedido = '/detallespedido';
  static const String addProduct = '/addProduct';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      createProfile: (context) => const CreateProfileScreen(),
      home: (context) => const HomeScreen(email: '',),
      pedidosEntrega : (context) => const Pedidosaentregarscreen(),
      editProfile: (context) => const EditProfileScreen(),
      addProduct: (context) => const AddProductScreen(),  
    };
  }
}
