import 'package:flutter/material.dart';

class PendingOrderItem extends StatelessWidget {
  final String pedido;
  final VoidCallback onTap;

  const PendingOrderItem({
    super.key,
    required this.pedido,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(pedido),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
