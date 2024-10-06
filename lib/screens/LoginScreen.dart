import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../controllers/AuthController.dart';
import 'HomeScreen.dart';
=======
>>>>>>> 90a96c5ca88dcfca314c8e67a84281804ffe9bc3

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _errorMessage = '';

  // Credenciales predefinidas
  final String _validEmail = '1@uv.com';
  final String _validPassword = 'password123';

  // Método principal para manejar el inicio de sesión
  void _login() async {
<<<<<<< HEAD
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    bool isSuccess = true;
=======
    if (_formKey.currentState?.validate() != true) {
      return; // Si el formulario no es válido, no continuar
    }
>>>>>>> 90a96c5ca88dcfca314c8e67a84281804ffe9bc3

    setState(() {
      _isLoading = true; // Mostrar indicador de carga
      _errorMessage = ''; // Limpiar mensaje de error
    });

<<<<<<< HEAD
      // Redirigir a la pantalla principal
    if (isSuccess) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
=======
    await Future.delayed(Duration(seconds: 2)); // Simulación de espera

    if (_isCredentialsValid()) {
      _navigateToHome(); // Navegar a la pantalla principal
    } else {
      _showError('Credenciales incorrectas'); // Mostrar mensaje de error
    }
  }

  // Método para validar las credenciales
  bool _isCredentialsValid() {
    return _emailController.text.trim() == _validEmail &&
        _passwordController.text == _validPassword;
  }

  // Método para navegar a la pantalla principal
  void _navigateToHome() {
    setState(() {
      _isLoading = false; // Detener el indicador de carga
    });
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: _emailController.text.trim(),
    );
  }

  // Método para mostrar un mensaje de error
  void _showError(String message) {
    setState(() {
      _isLoading = false; // Detener el indicador de carga
      _errorMessage = message; // Establecer mensaje de error
    });
  }

  // Método para construir el cuerpo de la pantalla
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
>>>>>>> 90a96c5ca88dcfca314c8e67a84281804ffe9bc3
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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

  // Método para construir el campo de correo electrónico
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
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

  // Método para construir el campo de contraseña
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
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

  // Método para construir el botón de inicio de sesión
  Widget _buildLoginButton() {
    return _isLoading
        ? const CircularProgressIndicator() // Mostrar indicador de carga
        : ElevatedButton(
            onPressed: _login,
            child: const Text('Iniciar sesión'),
          );
  }

  // Método para construir el botón de registro
  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/createProfile'); // Navegar a CreateProfile
      },
      child: const Text('Crear Perfil'),
    );
  }

  // Método para construir los botones de acción
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildLoginButton()), // Botón de inicio de sesión
        const SizedBox(width: 20),
        Expanded(child: _buildRegisterButton()), // Botón de crear perfil
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: _buildBody(), // Construir el cuerpo de la pantalla
    );
  }
}