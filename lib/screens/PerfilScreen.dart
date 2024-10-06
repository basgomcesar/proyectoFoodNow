import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  final String email;

  PerfilScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Puedes agregar más información del perfil aquí
            Text(
              'Correo Electrónico:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(email),
            // Añadir más detalles según sea necesario
          ],
        ),
      ),
    );
  }
}