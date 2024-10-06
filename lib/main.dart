import 'package:flutter/material.dart';// this line is added automatically by Flutter and is used to import material.dart file from the Flutter package which contains the material design widgets.
import 'screens/LoginScreen.dart'; // this line is added automatically by Flutter and is used to import the LoginScreen.dart file from the screens folder.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget { // this line is added automatically by Flutter and is used to create a stateless widget called MyApp and extends StatelessWidget class which is a base class for widgets that do not require mutable state.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}