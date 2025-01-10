import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:loging_app/core/utils/session.dart';
import 'package:loging_app/features/user/presentation/screens/ChangeAvailabilityScreen.dart';
import '../../../product/presentation/screens/ProductsOfferedView.dart';
import '../../../product/presentation/screens/ProductsChartView.dart';

class DrawerListView extends StatefulWidget {
  final String email;

  const DrawerListView({super.key, required this.email});

  @override
  _DrawerListViewState createState() => _DrawerListViewState();
}

class _DrawerListViewState extends State<DrawerListView> {
  late Uint8List? image;
  late String userName;
  late String userEmail;
  late bool userDisponibility;
  late String userLocation;
  late String userType;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = Session.instance.user;
    if (user != null) {
      image = user.photo != null ? Uint8List.fromList(user.photo) : null;
      userName = user.name;
      userEmail = user.email;
      userDisponibility = user.disponibility;
      userLocation = user.location;
      userType = user.userType;
    }
    print("tipo de usuario: " + userType);
  }

  @override
  Widget build(BuildContext context) {
    final userTypeProduct = Session.instance.user?.userType;

    final user = Session.instance.user; // Garantizar que user esté cargado
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
                          user != null && user.disponibility
                              ? "Disponible"
                              : "No disponible",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user?.location ?? 'Ubicación no disponible',
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
                          builder: (context) => const ChangeAvailability(),
                        ),
                      ).then((_) {
                        setState(() {
                          _loadUserData();
                        });
                      });
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
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userEmail,
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
        if (userType == 'Vendedor')
          ListTile(
            leading: const Icon(Icons.gite_rounded),
            title: const Text('Productos vendedor'),
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
          leading: const Icon(Icons.hiking_rounded),
          title: Text(
              userType == 'Cliente' ? 'Mis pedidos' : 'Pedidos a entregar'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context,
                userType == 'Cliente' ? '/customerOrders' : '/pendingOrders');
          },
        ),

        
        if (userType == 'Vendedor')
          ListTile(
          leading: const Icon(Icons.hiking_rounded),
          title: const Text('Estadísticas'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductsChartView(),
              ),
            );
          },
        ),

        
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Cerrar Sesión'),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Cerrar Sesión'),
                content:
                    const Text('¿Estás seguro de que deseas cerrar sesión?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Session.instance.endSession();
                      Navigator.pushReplacementNamed(context, '/login');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Sesión cerrada correctamente')),
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
