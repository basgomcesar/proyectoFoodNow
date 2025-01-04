import 'package:flutter/material.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';
import 'package:loging_app/features/product/domain/use_cases/place_order_use_case.dart';
import 'package:loging_app/features/product/presentation/bloc/placer_order/place_order_bloc.dart';
import 'package:loging_app/features/product/presentation/bloc/placer_order/place_order_event.dart';
import 'package:loging_app/features/product/presentation/bloc/placer_order/place_order_state.dart';
import 'package:loging_app/features/product/presentation/screens/ProductWaitingScreen.dart';
import 'package:loging_app/injection_container.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaceOrderBloc(serviceLocator<PlaceOrderUseCase>()),
      child: ProductDetailsScreenContent(product: product),
    );
  }
}

class ProductDetailsScreenContent extends StatefulWidget {
  final Product product;

  const ProductDetailsScreenContent({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreenContent> {
  int currentValue = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return BlocListener<PlaceOrderBloc, PlaceOrderState>(
      listener: (context, state) {
        if (state is PlaceOrderWaiting) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductWaitingscreen(state.order),
            ),
          );
        } else if (state is PlaceOrderDelivered) {
          Navigator.popUntil(context, (route) => route.isFirst);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pedido entregado con éxito')),
          );
        } else if (state is PlaceOrderError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
          Navigator.pushNamed(context, '/home');
        } else if (state is PlaceOrderCanceled) {
          Navigator.popUntil(context, (route) => route.isFirst);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pedido cancelado')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.memory(
                  product.photo,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Precio: ${product.price}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Descripción:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.description ?? 'Sin descripción disponible',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                "Cantidad:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              NumberPicker(
                value: currentValue,
                minValue: 1,
                maxValue: product.quantityAvailable,
                axis: Axis.horizontal,
                onChanged: (value) {
                  setState(() {
                    currentValue = value;
                  });
                },
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.red),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        currentValue =
                            (currentValue - 1).clamp(1, product.quantityAvailable);
                      });
                    },
                  ),
                  Text('Producto(s) seleccionado(s): $currentValue'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        currentValue =
                            (currentValue + 1).clamp(1, product.quantityAvailable);
                      });
                    },
                  ),
                ],
              ),
              ButtonsOptions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget ButtonsOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            _showDialog(widget.product, currentValue);
          },
          child: const Text('Pedir producto'),
        ),
      ],
    );
  }

  void _showDialog(Product product, int currentValue) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pedido por confirmar'),
        content: const Text(
          '¿Estás seguro de que deseas pedir este producto?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
              _placeOrder(product, currentValue);
            },
            child: const Text('Pedir'),
          ),
        ],
      ),
    );
  }

  void _placeOrder(Product product, int currentValue) {
    context.read<PlaceOrderBloc>().add(
          PlaceOrder(product, currentValue),
        );
  }
}
