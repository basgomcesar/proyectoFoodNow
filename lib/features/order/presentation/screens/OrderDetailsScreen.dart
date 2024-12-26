import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import 'package:loging_app/features/order/presentation/bloc/order_details_bloc/order_details_bloc.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';
import 'package:loging_app/features/order/presentation/bloc/order_details_bloc/order_details_bloc.dart';
import 'package:loging_app/features/user/presentation/widgets/header_logo.dart';

class OrderDetailsScreen extends StatefulWidget {
  final ProductsOrder pedido;

  const OrderDetailsScreen({
    super.key,
    required this.pedido, // Recibe el pedido seleccionado.
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Disparamos el evento para obtener los detalles del pedido cuando la pantalla se cargue.
    context.read<OrderDetailsBloc>().add(GetOrderDetails(widget.pedido.idPedido));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado
            LogoHeader(
              titulo: 'Detalles de Pedido',
              onNavigateBack: () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
            // Información del pedido
            const Text(
              "Pedido seleccionado:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'ID Pedido: ${widget.pedido.idPedido}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Estado: ${widget.pedido.estadoPedido}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Fecha: ${widget.pedido.fechaPedido.toLocal().toString()}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Cliente: ${widget.pedido.nombreCliente}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Mostrar detalles del producto
            BlocBuilder<OrderDetailsBloc, OrderDetailsBlocState>(
              builder: (context, state) {
                if (state is OrderDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OrderDetailsSuccess) {
                  final product = state.product;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Producto: ${product.name}', // Suponiendo que 'name' es el nombre del producto
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Precio: \$${product.price.toStringAsFixed(2)}', // Suponiendo que 'price' es el precio del producto
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Descripción: ${product.description}', // Suponiendo que 'description' es la descripción del producto
                        style: const TextStyle(fontSize: 16),
                      ),
                      // Puedes agregar más campos si es necesario
                    ],
                  );
                } else if (state is OrderDetailsFailure) {
                  return Center(
                    child: Text(
                      'Error al obtener los detalles del producto: ${state.message}',
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                } else {
                  return const SizedBox(); // En caso de que el estado sea el inicial o no esperado
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
