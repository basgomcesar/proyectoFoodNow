import 'package:flutter/material.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  // Lista de opciones para el combobox de tipo de usuario
  final List<String> _userTypes = ['Vendedor', 'Cliente'];
  String? _selectedUserType; // Variable para almacenar la opción seleccionada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildNameField(),
                const SizedBox(height: 16),
                _buildLastNameField(),
                const SizedBox(height: 16),
                _buildEmailField(),
                const SizedBox(height: 16),
                _buildPhoneField(),
                const SizedBox(height: 20),
                _buildUserTypeDropdown(),
                const SizedBox(height: 20),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Nombre',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingresa tu nombre';
        }
        return null;
      },
    );
  }

  Widget _buildLastNameField() {
    return TextFormField(
      controller: _lastNameController,
      decoration: const InputDecoration(
        labelText: 'Apellidos',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingresa tus apellidos';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Correo Electrónico',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
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

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      decoration: const InputDecoration(
        labelText: 'Número Telefónico',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingresa tu número telefónico';
        }
        return null;
      },
    );
  }
  
  // Combobox para seleccionar el tipo de usuario
  Widget _buildUserTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedUserType,
      decoration: const InputDecoration(
        labelText: 'Tipo de Usuario',
        border: OutlineInputBorder(),
      ),
      items: _userTypes.map((String userType) {
        return DropdownMenuItem<String>(
          value: userType,
          child: Text(userType),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedUserType = newValue;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Por favor, selecciona el tipo de usuario';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          // Aquí puedes manejar el envío del formulario, como guardar datos
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Perfil creado exitosamente')),
          );
          // Limpiar los campos después de enviar
          _nameController.clear();
          _lastNameController.clear();
          _emailController.clear();
          _phoneController.clear();
          setState(() {
            _selectedUserType = null; // Limpiar el combobox
          });
        }
      },
      child: const Text('Crear Perfil'),
    );
  }
}
