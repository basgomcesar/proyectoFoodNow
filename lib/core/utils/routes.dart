// core/utils/routes.dart
import 'package:flutter/material.dart';
import 'package:loging_app/features/user/presentation/screens/HomeScreen.dart';
import 'package:loging_app/features/user/presentation/screens/LoginScreen.dart';
import 'package:loging_app/features/user/presentation/screens/CreateProfileScreen.dart';
import 'package:loging_app/features/user/presentation/screens/EditProfileScreen.dart';
import 'package:loging_app/features/product/presentation/screens/AddProductScreen.dart';
import 'package:loging_app/features/order/presentation/screens/PendingOrdersScreen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String createProfile = '/createProfile';
  static const String home = '/home';
  static const String editProfile = '/editProfile';
  static const String pendingOrders = '/pendingOrders';
  static const String orderDetails = '/orderDetails';
  static const String addProduct = '/addProduct';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      createProfile: (context) => const CreateProfileScreen(),
      home: (context) => const HomeScreen(email: '',),
      pendingOrders: (context) => const PendingOrdersScreen(),
      editProfile: (context) => const EditProfileScreen(),
      addProduct: (context) => const AddProductScreen(),  
    };
  }
}
