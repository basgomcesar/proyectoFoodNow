import 'package:flutter/material.dart';

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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Cabecera del Drawer con información del usuario
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
              accountName: const Text('Miguel Caixba'),
              accountEmail: Text(widget.email), // Mostrar el correo electrónico pasado
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
                Navigator.pushNamed(context, '/perfil', arguments: widget.email);
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
              leading: const Icon(Icons.directions_run ),
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
        ),
      ),
      body: const Center(
        child: Text('Contenido de Inicio'),
      ),
    );
  }
}
