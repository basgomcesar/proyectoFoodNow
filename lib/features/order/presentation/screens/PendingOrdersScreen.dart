import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/order/domain/use_cases/get_pending_orders.dart';
import 'package:loging_app/features/order/presentation/bloc/order_details_bloc/order_details_bloc.dart';
import 'package:loging_app/features/order/presentation/bloc/pending_orders_bloc/pending_orders_bloc.dart';
import 'package:loging_app/features/order/presentation/screens/OrderDetailsScreen.dart';
import 'package:loging_app/features/product/domain/use_cases/get_order_product.dart';
import 'package:loging_app/features/user/presentation/widgets/header_logo.dart';
import 'package:loging_app/features/order/presentation/widgets/pending_order_item.dart';
import 'package:loging_app/injection_container.dart';

class PendingOrdersScreen extends StatelessWidget {
  const PendingOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PendingOrdersBloc(
        getPendingOrders: serviceLocator<GetPendingOrdersUseCase>(),
      )..add(OrderGetPendingOrders()),
      child: const PendingOrdersContent(),
    );
  }
}

class PendingOrdersContent extends StatelessWidget {
  const PendingOrdersContent({super.key});

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
            // Lista de pedidos con BlocBuilder
            Expanded(
              child: BlocBuilder<PendingOrdersBloc, PendingOrdersState>(
                builder: (context, state) {
                  if (state is PendingOrdersFailure) {
                    return Center(child: Text(state.message));
                  } else if (state is PendingOrdersSuccess) {
                    final pedidos = state.orders;
                    return ListView.builder(
                      itemCount: pedidos.length,
                      itemBuilder: (context, index) {
                        final pedido = pedidos[index];
                        return PendingOrderItem(
                          pedido: 'Cliente: ${pedido.nombreCliente}',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => OrderDetailsBloc(
                                    getOrderProduct: context.read<GetOrderProduct>(),
                                  ),
                                  child: OrderDetailsScreen(
                                    pedido: pedido,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
