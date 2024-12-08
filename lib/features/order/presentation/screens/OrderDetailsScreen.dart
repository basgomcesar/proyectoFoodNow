import 'package:flutter/material.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import 'package:loging_app/features/user/presentation/widgets/header_logo.dart';

class DetallesPedidoScreen extends StatefulWidget {
  final ProductsOrder pedido;

  const DetallesPedidoScreen({
    super.key,
    required this.pedido, // Recibe el pedido seleccionado.
  });

  @override
  State<DetallesPedidoScreen> createState() => _DetallesPedidoScreenState();
}

class _DetallesPedidoScreenState extends State<DetallesPedidoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              widget.pedido, // Muestra los datos del pedido seleccionado.
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
