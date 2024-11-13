import 'package:flutter/material.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';

class ProductBox extends StatelessWidget {
  final Product product;

  const ProductBox({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('ID: ${product.id}'),
            Text('Available: ${product.available ? 'Yes' : 'No'}'),
            Text('Status: ${product.status}'),
          ],
        ),
      ),
    );
  }
}
