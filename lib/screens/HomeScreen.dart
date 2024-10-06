import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  // Constructor para recibir el correo electrónico
  HomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Puedes añadir más variables de estado si es necesario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Cabecera del Drawer con información del usuario
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              accountName: Text('Miguel Caixba'),
              accountEmail: Text(widget.email), // Mostrar el correo electrónico pasado
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://picsum.photos/200'),
              ),
            ),
            // Opción de Perfil
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {
                Navigator.pop(context); // Cerrar el Drawer
                Navigator.pushNamed(context, '/perfil', arguments: widget.email);
              },
            ),
            // Otras opciones del Drawer
            ListTile(
              leading: Icon(Icons.gite_rounded),
              title: Text('Productos'),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, '/configuraciones');
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_run ),
              title: Text('Pedidos a recoger'),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, '/historial');
              },
            ),
            ListTile(
              leading: Icon(Icons.hiking_rounded),
              title: Text('Pedidos a entregar'),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, '/ayuda');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Acerca de'),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, '/acerca');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar Sesión'),
              onTap: () {
                Navigator.pop(context);
                // Navegar de regreso al LoginScreen y reemplazar la pila de navegación
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Contenido de Inicio'),
      ),
    );
  }
}
