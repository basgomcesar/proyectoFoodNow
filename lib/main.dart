import 'package:flutter/material.dart';
import 'package:loging_app/features/user/presentation/screens/LoginScreen.dart';
import 'features/user/presentation/screens/LoginScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/PerfilScreen.dart';
import 'screens/CreateProfile.dart';
import 'package:flutter/material.dart'; //PRUEBA FIREBASE
import 'package:firebase_core/firebase_core.dart'; //PRUEBA FIREBASE


void main() async{//PRUEBA FIREBASE
  WidgetsFlutterBinding.ensureInitialized(); //PRUEBA FIREBASE
  await Firebase.initializeApp(); //PRUEBA FIREBASE
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 // this line is added automatically by Flutter and is used to create a stateless widget called MyApp and extends StatelessWidget class which is a base class for widgets that do not require mutable state.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange,),
      home:  const LoginScreen(),
    );
  }
}