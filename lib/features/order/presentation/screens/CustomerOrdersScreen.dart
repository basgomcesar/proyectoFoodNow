import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/order/domain/use_cases/get_customer_orders.dart';
import 'package:loging_app/features/order/presentation/bloc/customer_orders_bloc/customer_orders_bloc.dart';
import 'package:loging_app/features/order/presentation/bloc/order_details_bloc/order_details_bloc.dart';
import 'package:loging_app/features/order/presentation/screens/OrderDetailsScreen.dart';
import 'package:loging_app/features/product/domain/use_cases/get_order_product.dart';
import 'package:loging_app/features/user/presentation/widgets/header_logo.dart';
import 'package:loging_app/features/order/presentation/widgets/pending_order_item.dart';
import 'package:loging_app/injection_container.dart';

class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomerOrdersBloc(
        getCustomerOrders: serviceLocator<GetCustomerOrders>(),
      )..add(CustomerGetCustomerOrders()), // Añade esta línea para disparar el evento
      child: const CustomerOrdersContent(),
    );
  }
}

class CustomerOrdersContent extends StatelessWidget {
  const CustomerOrdersContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Encabezado
            LogoHeader(
              titulo: 'Pedidos activos',
              onNavigateBack: () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
            // Lista de pedidos con BlocBuilder
            Expanded(
              child: BlocBuilder<CustomerOrdersBloc, CustomerOrdersState>(
                builder: (context, state) {
                  if (state is CustomerOrdersFailure) {
                    return Center(child: Text(state.message));
                  } else if (state is CustomerOrdersSuccess) {
                    final pedidos = state.orders; // Aquí obtienes la lista
                    return ListView.builder(
                      itemCount: pedidos.length,
                      itemBuilder: (context, index) {
                        final pedido = pedidos[index];
                        return PendingOrderItem(
                          pedido: 'Vendedor: ${pedido.nombreVendedor}',
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
