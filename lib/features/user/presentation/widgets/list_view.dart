import 'package:flutter/material.dart';

class DrawerListView extends StatelessWidget {
  final String email;

  const DrawerListView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Cabecera del Drawer con información del usuario
        UserAccountsDrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
          ),
          accountName: const Text('Miguel Caixba'),
          accountEmail: Text(email), // Mostrar el correo electrónico pasado
          currentAccountPicture: const CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/200'),
          ),
        ),
        // Opción de Perfil
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Perfil'),
          onTap: () {
            Navigator.pop(context); // Cerrar el Drawer
            Navigator.pushNamed(context, '/perfil', arguments: email);
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
            Navigator.pop(context);
            // Navegar de regreso al LoginScreen y reemplazar la pila de navegación
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ],
    );
  }
}