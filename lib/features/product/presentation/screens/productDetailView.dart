import 'package:flutter/material.dart';
import 'package:loging_app/features/product/domain/entities/product.dart';
import 'package:numberpicker/numberpicker.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int currentValue = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
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
                itemWidth: MediaQuery.of(context).size.width / 3, 
              onChanged: (value) {
                setState(() {
                  currentValue = value;
                });
              },
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color.fromARGB(255, 255, 0, 0)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      final newValue = currentValue - 1;
                      currentValue = newValue.clamp(1, product.quantityAvailable);
                    });
                  },
                ),
                Text('Producto(s) seleccionado(s): $currentValue'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      final newValue = currentValue + 1;
                      currentValue = newValue.clamp(1, product.quantityAvailable);
                    });
                  },
                ),
              ],
            ),
            ButtonsOptions()

          ],
        ),
      ),
    );
  }

  Widget ButtonsOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
            ),
          ),
          onPressed: () {
            // Add to cart
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            // Buy now
          },
          child: const Text('Pedir producto'),
        ),
      ],
    );
  }
}
