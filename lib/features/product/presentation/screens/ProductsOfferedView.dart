import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/core/utils/session.dart';
import '../bloc/product_seller_bloc/products_seller_bloc.dart';
import '../bloc/product_seller_bloc/products_seller_event.dart';
import '../bloc/product_seller_bloc/products_seller_state.dart';
import 'AddProductScreen.dart';

class ProductsOfferedScreen extends StatefulWidget {
  const ProductsOfferedScreen({Key? key}) : super(key: key);

  @override
  _ProductsOfferedScreenState createState() => _ProductsOfferedScreenState();
}

class _ProductsOfferedScreenState extends State<ProductsOfferedScreen> {
  @override
  void initState() {
    super.initState();
    final session = Session.instance;
    if (session.userId != null) {
      // Realiza la llamada a la API directamente en initState
      BlocProvider.of<ProductsSellerBloc>(context).add(
        FetchProductsSeller(session.userId!),
      );
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos Ofrecidos'),
        backgroundColor: const Color.fromRGBO(228, 144, 40, 1),
      ),
      body: BlocBuilder<ProductsSellerBloc, ProductsSellerState>(
        builder: (context, state) {
          if (state is ProductsSellerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsSellerLoaded) {
            final products = state.products;

            if (products.isEmpty) {
              return const Center(child: Text('No hay productos disponibles.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 4.0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/dish.png',  // Aquí puedes cambiar por la foto si la tienes
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Categoría: ${product.category ?? 'N/A'}\nDisponible: ${product.quantityAvailable} unidades\nPrecio: \$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Eliminar ${product.name}')),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProductScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ProductsSellerError) {
            _showErrorDialog(state.message);
            return const Center(child: Text('Error al cargar los productos.'));
          }
          return const Center(child: Text('No hay productos para mostrar.'));
        },
      ),
    );
  }
}