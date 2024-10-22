import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode(); // FocusNode para el campo de email
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isKeyboardVisible = false; // Verificar si el teclado está visible

  @override
  void initState() {
    super.initState();

    // Escuchar cambios en el FocusNode
    _emailFocusNode.addListener(_handleFocusChange);
  }

  // Método para manejar el cambio de foco
  void _handleFocusChange() {
    if (_emailFocusNode.hasFocus) {
      setState(() {
        _isKeyboardVisible = true; // Ocultar el logo cuando el campo de email tenga foco
      });
    } else {
      setState(() {
        _isKeyboardVisible = false; // Mostrar el logo cuando el foco se pierde
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose(); // Liberar el FocusNode cuando ya no se necesita
    super.dispose();
  }

  // Método para construir el logotipo
  Widget _buildLogo() {
    // Ocultar el logo si el teclado está visible
    if (_isKeyboardVisible) {
      return const SizedBox.shrink();
    }
    return SvgPicture.asset(
      'assets/loginIcon.svg',
      width: 200,
      height: 200,
    );
  }

  // Método para construir el campo de correo electrónico
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocusNode, // Vincular el FocusNode al campo de email
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Por favor, ingresa tu correo electrónico';
        }
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(value.trim())) {
          return 'Por favor, ingresa un correo electrónico válido';
        }
        return null;
      },
    );
  }

  // Método para construir el cuerpo de la pantalla
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildLogo(), // Logo que se ocultará si el teclado está visible
            const SizedBox(height: 20),
            _buildIniciarSesionLabel(),
            const SizedBox(height: 20),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty) _buildErrorMessage(),
            const SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  // Método para construir el texto de inicio de sesión
  Widget _buildIniciarSesionLabel() {
    return const Text(
      'Iniciar sesión',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  // Método para construir el campo de contraseña
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
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
    );
  }

  // Método para construir el mensaje de error
  Widget _buildErrorMessage() {
    return Text(
      _errorMessage,
      style: const TextStyle(color: Colors.red),
    );
  }

  // Método para construir los botones de acción
  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _login,
          child: _isLoading
              ? const CircularProgressIndicator()
              : const Text('Iniciar sesión'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/createProfile');
          },
          child: const Text('Crear Perfil'),
        ),
      ],
    );
  }

  // Método principal para manejar el inicio de sesión
  void _login() {
    if (_formKey.currentState?.validate() == true) {
      // Lógica de login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
}
