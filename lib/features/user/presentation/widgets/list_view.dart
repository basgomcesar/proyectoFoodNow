import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:loging_app/core/utils/session.dart';
import '../screens/ChangeAvailability.dart';

class DrawerListView extends StatelessWidget {
  final String email;
  final user = Session.instance.user;
  final Uint8List? image = Session.instance.user?.photo != null
      ? Uint8List.fromList(Session.instance.user!.photo)
      : null;

  DrawerListView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Cabecera personalizada del Drawer
        Container(
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Imagen del perfil
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: image != null
                        ? Image.memory(image!).image
                        : const AssetImage('assets/images/default_avatar.png'),
                  ),
                  const SizedBox(width: 16),
                  // Leyenda "Disponible" y "Ubicación"
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ // Añadido `const` aquí
                      Text(
                        'Disponible', // Leyenda "Disponible"
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Ubicación: Salón 104', // Leyenda de ubicación
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                  // Ícono ">"
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SecondScreen()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Información del usuario (centrada hacia la izquierda)
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user!.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user!.email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Opciones del Drawer
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Editar perfil'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/editProfile');
          },
        ),
        ListTile(
          leading: const Icon(Icons.gite_rounded),
          title: const Text('Productos'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.directions_run),
          title: const Text('Pedidos a recoger'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.hiking_rounded),
          title: const Text('Pedidos a entregar'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('Acerca de'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Cerrar Sesión'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ],
    );
  }
}
