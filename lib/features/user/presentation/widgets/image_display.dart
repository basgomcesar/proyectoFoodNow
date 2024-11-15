import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final Uint8List? imageBytes;

  const ImageDisplay({super.key, this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Usa un tamaño fijo inicial si no hay imagen, o el tamaño disponible si la imagen es cargada
        double containerWidth = 200; // Tamaño fijo inicial
        double containerHeight = 200; // Tamaño fijo inicial

        // Si tienes la imagen, ajusta el tamaño al tamaño real de la imagen
        if (imageBytes != null) {
          // Calcula el tamaño que ocupa la imagen, pero mantén el contenedor dentro del límite
          final image = Image.memory(
            imageBytes!,
            width: constraints.maxWidth, // Usa el tamaño máximo disponible
            height: constraints.maxHeight, // Usa el tamaño máximo disponible
            fit: BoxFit.contain,  // Ajusta la imagen sin recortar
          );

          // Regresa un contenedor que se adapta a la imagen
          return Container(
            width: containerWidth,
            height: containerHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: image,
          );
        } else {
          // Si no hay imagen, muestra el ícono en un contenedor de tamaño fijo
          return Container(
            width: containerWidth,
            height: containerHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300], // Fondo gris si no hay imagen
            ),
            child: Center(
              child: Icon(
                Icons.image,
                color: Colors.grey[600],
                size: 50,
              ),
            ),
          );
        }
      },
    );
  }
}