import 'package:flutter/material.dart';
import 'package:loging_app/features/order/presentation/screens/detallespedidoscreen.dart';
import 'package:loging_app/features/user/presentation/widgets/header_logo.dart';
import 'package:loging_app/features/order/presentation/widgets/pending_order_item.dart';

class Pedidosaentregarscreen extends StatefulWidget {
  const Pedidosaentregarscreen({super.key});

  @override
  State<Pedidosaentregarscreen> createState() => _PedidosaentregarscreenState();
}

class _PedidosaentregarscreenState extends State<Pedidosaentregarscreen> {
  // Simula la lista de pedidos recuperada de la base de datos.
  final List<String> pedidos = [
    '1 HotDog a Marina',
    '2 Hamburguesas a Juan',
    '1 Pizza a Sofía',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Encabezado
            LogoHeader(
              titulo: 'Pedidos a Entregar',
              onNavigateBack: () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
            // Lista de pedidos
            Expanded(
              child: ListView.builder(
                itemCount: pedidos.length,
                itemBuilder: (context, index) {
                  final pedido = pedidos[index];
                  return PendingOrderItem(
                    pedido: pedido,
                    onTap: () {
                      // Navega a la pantalla de detalles pasando el pedido seleccionado.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetallesPedidoScreen(
                            pedido: pedido,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
