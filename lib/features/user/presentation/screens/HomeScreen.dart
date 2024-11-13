import 'package:flutter/material.dart';
import 'package:loging_app/features/user/presentation/widgets/list_view.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  // Constructor para recibir el correo electrónico
  const HomeScreen({super.key, required this.email});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Puedes añadir más variables de estado si es necesario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
      ),
      drawer: Drawer(
        child: DrawerListView(email: widget.email),
      ),
      body: const Center(
        child: Text('Contenido de Inicio'),
      ),
    );
  }
}