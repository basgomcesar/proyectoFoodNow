<<<<<<< HEAD
import 'package:flutter/material.dart';// this line is added automatically by Flutter and is used to import material.dart file from the Flutter package which contains the material design widgets.
import 'screens/LoginScreen.dart'; // this line is added automatically by Flutter and is used to import the LoginScreen.dart file from the screens folder.
=======
import 'package:flutter/material.dart';
import 'screens/loginScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/PerfilScreen.dart';
import 'screens/CreateProfile.dart';

>>>>>>> 90a96c5ca88dcfca314c8e67a84281804ffe9bc3

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget { // this line is added automatically by Flutter and is used to create a stateless widget called MyApp and extends StatelessWidget class which is a base class for widgets that do not require mutable state.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final String email = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => HomeScreen(email: email),
          );
        } else if (settings.name == '/perfil') {
          final String email = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => PerfilScreen(email: email),
          );
        } else if (settings.name == '/createProfile') {
          return MaterialPageRoute(
            builder: (context) => CreateProfile(),
          );
        }
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      },
    );
  }
}