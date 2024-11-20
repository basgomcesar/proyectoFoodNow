import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onCreateAccountPressed;

  const ActionButtons({super.key, required this.onLoginPressed, required this.onCreateAccountPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onLoginPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(220, 107, 39, 1),
          ),
          child: const Text(
            'Iniciar sesión',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('¿No tienes una cuenta?'),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onCreateAccountPressed,
              child: const Text(
                'Crear cuenta',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
