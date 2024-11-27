import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:loging_app/core/utils/session.dart';

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
        // Cabecera del Drawer con información del usuario
        UserAccountsDrawerHeader(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(220, 107, 39, 1),
          ),
          accountName: Text(user!.name), // Mostrar el nombre pasado
          accountEmail: Text(user!.email), // Mostrar el correo electrónico pasado
          currentAccountPicture: CircleAvatar(
                backgroundImage: image != null
                ? Image.memory(image!).image
                : const AssetImage('assets/images/default_avatar.png'),
          ),
        ),
        // Opción de Perfil
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Editar perfil'),
          onTap: () {
            Navigator.pop(context); // Cerrar el Drawer
            Navigator.pushNamed(context, '/editProfile');
          },
        ),
        // Otras opciones del Drawer
        ListTile(
          leading: const Icon(Icons.gite_rounded),
          title: const Text('Productos'),
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/configuraciones');
          },
        ),
        ListTile(
          leading: const Icon(Icons.directions_run),
          title: const Text('Pedidos a recoger'),
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/historial');
          },
        ),
        ListTile(
          leading: const Icon(Icons.hiking_rounded),
          title: const Text('Pedidos a entregar'),
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/ayuda');
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('Acerca de'),
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/acerca');
          },
        ),
        const Divider(),
        ListTile(
  leading: const Icon(Icons.logout),
  title: const Text('Cerrar Sesión'),
  onTap: () {
    // Mostrar un diálogo de confirmación antes de cerrar sesión
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cerrar el diálogo sin hacer nada
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); 
              Session.instance.endSession();
              Navigator.pushReplacementNamed(context, '/login');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sesión cerrada correctamente')),
              );
            },
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  },
),

      ],
    );
  }
}