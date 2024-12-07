import 'package:flutter/material.dart';

class ImagePickerButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ImagePickerButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFDC6B27),  // Fondo del botón
        foregroundColor: Colors.white, // Color del texto
      ),
      child: const Text('Seleccionar Foto'),
    );
  }
}
