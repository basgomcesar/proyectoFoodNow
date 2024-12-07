import 'package:flutter/material.dart';

class AddProductButtom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Acción para agregar un producto
        print("Botón de agregar presionado");
        Navigator.pushNamed(context, '/addProduct'); // Redirigir a la pantalla '/addProduct'

      },
      child: const Icon(Icons.add),  // El icono de agregar (+)
      tooltip: 'Agregar Producto',  // Texto que aparece cuando el usuario mantiene presionado el botón
      backgroundColor: Color(0xFFDC6B27),  // Color de fondo del botón
      foregroundColor: Colors.white,
    );
    
  }
  
}

