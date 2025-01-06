import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/order/domain/entities/products_order.dart';
import 'package:loging_app/features/order/domain/use_cases/cancel_order.dart';
import 'package:loging_app/features/order/domain/use_cases/confirm_order.dart';
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

class OrderDetailsContent extends StatefulWidget {
  final ProductOrder pedido;

  const OrderDetailsContent({
    super.key,
    required this.pedido,
  });

  @override
  State<OrderDetailsContent> createState() => _OrderDetailsContentState();
}

class _OrderDetailsContentState extends State<OrderDetailsContent> {
  late String estadoPedido;
  bool botonHabilitado = true;

  @override
  void initState() {
    super.initState();
    estadoPedido = widget.pedido.estadoPedido; // Estado inicial del pedido
  }

  Future<bool> showConfirmationDialog(BuildContext context, String title, String content) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Sí'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> showMessageDialog(BuildContext context, String title, String content) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
            buildInfoRow('Estado:', estadoPedido),
            buildInfoRow(
              'Fecha:',
              widget.pedido.fechaPedido.toLocal().toString(),
            ),
            buildInfoRow(
              widget.pedido.nombreCliente == "Sin nombre" ? 'Vendedor:' : 'Cliente:',
              widget.pedido.nombreCliente == "Sin nombre"
                  ? widget.pedido.nombreVendedor
                  : widget.pedido.nombreCliente,
            ),
            const SizedBox(height: 20),
            // Detalles del producto
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
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Detalles del producto en el lado izquierdo
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildInfoRow('Producto:', product.name),
                            buildInfoRow('Cantidad:', widget.pedido.cantidad.toString()),
                            buildInfoRow(
                              'Precio:',
                              '\$${product.price.toStringAsFixed(2)}',
                            ),
                            buildInfoRow('Descripción:', product.description ?? 'Sin descripción'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16), // Separador entre texto e imagen
                      
                      // Imagen del producto en el lado derecho
                      Expanded(
                        flex: 1,
                        child: product.photo.isNotEmpty
                            ? Image.memory(
                                product.photo,
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                              )
                            : const Icon(
                                Icons.image_not_supported,
                                size: 150,
                                color: Colors.grey,
                              ), // Icono predeterminado si no hay imagen
                      ),
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

            // Botón para cancelar el pedido
            if (widget.pedido.nombreCliente == "Sin nombre")
              ElevatedButton(
                onPressed: botonHabilitado
                    ? () async {
                        final confirm = await showConfirmationDialog(
                          context,
                          'Confirmación',
                          '¿Realmente deseas cancelar el pedido?',
                        );

                        if (!confirm) return;

                        final cancelOrderUseCase = serviceLocator<CancelOrderUseCase>();

                        try {
                          final result = await cancelOrderUseCase.call(widget.pedido.idPedido);

                          await result.fold(
                            (failure) async {
                              await showMessageDialog(
                                context,
                                'Error',
                                'Error al cancelar el pedido: ${failure.message}',
                              );
                            },
                            (success) async {
                              await showMessageDialog(
                                context,
                                'Éxito',
                                'Pedido cancelado con éxito',
                              );
                              Navigator.pushNamed(context, '/home');
                              /*setState(() {
                                estadoPedido = 'Cancelado'; // Actualizar estado
                                botonHabilitado = false; // Deshabilitar botón
                              });*/
                            },
                          );
                        } catch (e) {
                          await showMessageDialog(
                            context,
                            'Error inesperado',
                            'Ocurrió un error inesperado: $e',
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: botonHabilitado ? Colors.red : Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: const Text(
                  'Cancelar pedido',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )
              else
              //Boton para confirmar entrega
              ElevatedButton(
                onPressed: botonHabilitado
                    ? () async {
                        final confirm = await showConfirmationDialog(
                          context,
                          'Confirmación',
                          '¿Realmente deseas confirmar la entrega del pedido?',
                        );

                        if (!confirm) return;

                        final confirmOrderUseCase = serviceLocator<ConfirmOrderUseCase>();

                        try {
                          final result = await confirmOrderUseCase.call(widget.pedido.idPedido);

                          await result.fold(
                            (failure) async {
                              await showMessageDialog(
                                context,
                                'Error',
                                'Error al confirmar la entrega del pedido: ${failure.message}',
                              );
                            },
                            (success) async {
                              await showMessageDialog(
                                context,
                                'Éxito',
                                'Pedido entregado con éxito',
                              );
                              Navigator.pushNamed(context, '/home');
                              /*setState(() {
                                estadoPedido = 'Entregado'; // Actualizar estado
                                botonHabilitado = false; // Deshabilitar botón
                              });*/
                            },
                          );
                        } catch (e) {
                          await showMessageDialog(
                            context,
                            'Error inesperado',
                            'Ocurrió un error inesperado: $e',
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: botonHabilitado ? Colors.green : Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: const Text(
                  'Confirmar entrega',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            const SizedBox(height: 16),
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
