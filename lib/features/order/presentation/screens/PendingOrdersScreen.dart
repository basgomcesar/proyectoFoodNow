import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/order/presentation/bloc/pending_orders_bloc.dart';
import 'package:loging_app/features/order/presentation/screens/OrderDetailsScreen.dart';
import 'package:loging_app/features/user/presentation/widgets/header_logo.dart';
import 'package:loging_app/features/order/presentation/widgets/pending_order_item.dart';

class Pedidosaentregarscreen extends StatelessWidget {
  const Pedidosaentregarscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BlocProvider.of<PendingOrdersBloc>(context)..add(OrderGetPendingOrders()),
      child: Scaffold(
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
              // Lista de pedidos con BlocBuilder
              Expanded(
                child: BlocBuilder<PendingOrdersBloc, PendingOrdersState>(
                  builder: (context, state) {
                    if (state is PendingOrdersInitial) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PendingOrdersFailure) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else if (state is PendingOrdersSuccess) {
                      final pedidos = state.orders; // Aquí obtienes la lista
                      return ListView.builder(
                        itemCount: pedidos.length,
                        itemBuilder: (context, index) {
                          final pedido = pedidos[index];
                          return PendingOrderItem(
                            pedido: pedido.fechaPedido.toString(),
                            onTap: () {
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
                      );
                    } else {
                      return const Center(child: Text('No hay pedidos pendientes.'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
