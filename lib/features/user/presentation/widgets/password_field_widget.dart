import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const PasswordField({super.key, required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(constraints: BoxConstraints(maxWidth: 700),
    child:  Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: const InputDecoration(
          labelText: 'Contraseña',
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa tu contraseña';
          }
          if (value.length < 6) {
            return 'La contraseña debe tener al menos 6 caracteres';
          }
          return null;
        },
      ),
    )
    );
  }
}