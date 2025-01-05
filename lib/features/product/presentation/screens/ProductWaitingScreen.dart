import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/product/domain/entities/product_order.dart';
import 'package:loging_app/features/product/presentation/bloc/placer_order/place_order_bloc.dart';
import 'package:loging_app/features/product/presentation/bloc/placer_order/place_order_state.dart';

class ProductWaitingScreen extends StatelessWidget {
  final ProductOrder productOrder;

  const ProductWaitingScreen({required this.productOrder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
      builder: (context, state) {
        if (state is PlaceOrderInitial) {
          return Center(
            child: _ProductWaitingScreenContent(productOrder: productOrder),
          );
        } else if (state is PlaceOrderError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is PlaceOrderDelivered) {
          return const Center(
            child: Text("Pedido entregado"),
          );
        } else if (state is PlaceOrderCanceled) {
          return const Center(
            child: Text("Pedido cancelado"),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _ProductWaitingScreenContent extends StatelessWidget {
  final ProductOrder productOrder;

  const _ProductWaitingScreenContent({required this.productOrder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la orden'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time,
                  size: 80,
                  color: Colors.orange,
                ),
                SizedBox(width: 16),
                Icon(
                  Icons.more_horiz,
                  size: 40,
                  color: Colors.orange,
                ),
                SizedBox(width: 16),
                Icon(
                  Icons.fastfood,
                  size: 80,
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  'El vendedor:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                productOrder.sellerName, // Usando información del `ProductOrder`.
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  size: 30,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  'Está en:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                productOrder.sellerLocation, // Usando información del `ProductOrder`.
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
