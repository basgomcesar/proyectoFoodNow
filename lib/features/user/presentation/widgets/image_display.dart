// image_display.dart
import 'dart:io';
import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final File? imageFile;

  const ImageDisplay({Key? key, this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // Bordes redondeados
      child: Container(
        width: 100,  // Ajusta el tamaño como lo desees
        height: 100, // Ajusta el tamaño como lo desees
        color: Colors.grey[300], // Color de fondo mientras se carga la imagen
        child: imageFile != null
            ? Image.file(
                imageFile!,  // Muestra la imagen seleccionada
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            : Center(
                child: Icon(
                  Icons.image, // Ícono que se muestra si no hay imagen seleccionada
                  color: Colors.grey[600],
                  size: 50,
                ),
              ),
      ),
    );
  }
}
