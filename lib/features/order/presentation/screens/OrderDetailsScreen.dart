import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import 'package:loging_app/features/order/presentation/bloc/order_details_bloc/order_details_bloc.dart';
import 'package:loging_app/features/product/domain/use_cases/get_order_product.dart';
import 'package:loging_app/features/user/presentation/widgets/header_logo.dart';
import 'package:loging_app/injection_container.dart';

class OrderDetailsScreen extends StatelessWidget {
  final ProductOrder pedido;

  const OrderDetailsScreen({
    super.key,
    required this.pedido,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderDetailsBloc(
        getOrderProduct: serviceLocator<GetOrderProduct>(),
      )..add(GetOrderDetails(pedido.idPedido)),
      child: OrderDetailsContent(pedido: pedido),
    );
  }
}

class OrderDetailsContent extends StatelessWidget {
  final ProductOrder pedido;

  const OrderDetailsContent({
    super.key,
    required this.pedido,
  });

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
              titulo: 'Detalles del pedido',
              onNavigateBack: () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
            // Información del pedido
            const Text(
              "Pedido seleccionado:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            buildInfoRow('Estado:', pedido.estadoPedido),
            buildInfoRow(
              'Fecha:',
              pedido.fechaPedido.toLocal().toString(),
            ),
            buildInfoRow(
              pedido.nombreCliente == "Sin nombre" ? 'Vendedor:' : 'Cliente:',
              pedido.nombreCliente == "Sin nombre" ? pedido.nombreVendedor : pedido.nombreCliente,
            ),
            const SizedBox(height: 20),
            // Mostrar detalles del producto
            const Text(
              "Detalles del producto:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            BlocBuilder<OrderDetailsBloc, OrderDetailsBlocState>(
              builder: (context, state) {
                if (state is OrderDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OrderDetailsSuccess) {
                  final product = state.product;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfoRow('Producto:', product.name),
                      buildInfoRow(
                        'Precio:',
                        '\$${product.price.toStringAsFixed(2)}',
                      ),
                      buildInfoRow('Descripción:', product.description ?? 'Sin descripción'),
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
                  return const SizedBox();
                }
              },
            ),
            const Spacer(),
            
            if (pedido.nombreCliente == "Sin nombre")
              ElevatedButton(
                onPressed: () {
                  // Lógica para cancelar el pedido
                  print('Pedido cancelado'); // Placeholder
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: const Text(
                  'Cancelar pedido',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            const SizedBox(height: 16), // Espaciado final
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black),
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: ' $value',
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
