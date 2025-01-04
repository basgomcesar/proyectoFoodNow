import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';
import 'package:loging_app/features/product/domain/entities/product_order.dart';
import 'package:loging_app/features/product/presentation/bloc/placer_order/place_order_bloc.dart';
import 'package:loging_app/features/product/presentation/bloc/placer_order/place_order_state.dart';

class ProductWaitingscreen extends StatelessWidget {
  

  const ProductWaitingscreen(ProductOrder productOrder, {super.key});

  @override
  Widget build(BuildContext context) {
    //aqui se muestra el estado de la orden en espera
    return BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
      builder: (context, state) {
        if (state is PlaceOrderInitial) {
          return const Center(
            //child: CircularProgressIndicator(),
            child: _ProductWaitingScreenContent(),
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
  const _ProductWaitingScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del producto'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
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
            SizedBox(height: 40),
            Row(
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
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                'Nombre vendedor',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 24),
            Row(
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
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                'Ubicación del vendedor',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
