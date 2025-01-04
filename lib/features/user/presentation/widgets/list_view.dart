import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:loging_app/core/utils/session.dart';
import 'package:loging_app/features/user/presentation/screens/ChangeAvailabilityScreen.dart';
import '../../../product/presentation/screens/ProductsOfferedView.dart';
import '../../../product/presentation/screens/ProductsChartView.dart';


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
        Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(220, 107, 39, 1),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: image != null
                        ? Image.memory(image!).image
                        : const AssetImage('assets/images/default_avatar.png'),
                  ),
                  const SizedBox(width: 16),
                 Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ 
                      Text(
                        user!.disponibility ? "Disponible" : "No disponible", 
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user!.location,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
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
                            builder: (context) => ChangeAvailability()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductsOfferedScreen(),
              ),
            );
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
  leading: const Icon(Icons.hiking_rounded),
  title: const Text('Estadísticas'),
  onTap: () {
    Navigator.pop(context); // Cierra el Drawer
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsChartView(), 
      ),
    );
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
