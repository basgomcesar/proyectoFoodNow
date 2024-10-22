import 'package:flutter/material.dart';
import 'screens/loginScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/PerfilScreen.dart';
import 'screens/CreateProfile.dart';
import 'package:flutter/material.dart'; //PRUEBA FIREBASE
import 'package:firebase_core/firebase_core.dart'; //PRUEBA FIREBASE


void main() async{//PRUEBA FIREBASE
  WidgetsFlutterBinding.ensureInitialized(); //PRUEBA FIREBASE
  await Firebase.initializeApp(); //PRUEBA FIREBASE
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 // this line is added automatically by Flutter and is used to create a stateless widget called MyApp and extends StatelessWidget class which is a base class for widgets that do not require mutable state.
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