import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/user/domain/use_cases/create_profile_use_case.dart';
import 'package:loging_app/features/user/presentation/bloc/create_profile/create_profile_bloc.dart';
import 'package:loging_app/features/user/presentation/bloc/create_profile/create_profile_event.dart';
import 'package:loging_app/features/user/presentation/bloc/create_profile/create_profile_state.dart';
import 'package:loging_app/features/user/presentation/widgets/custom_text_field.dart';
import 'package:loging_app/features/user/presentation/widgets/header_logo.dart';
import 'package:loging_app/features/user/presentation/widgets/custom_dropdown_field.dart';
import 'package:loging_app/features/user/presentation/widgets/image_display.dart'; 
import 'package:loging_app/features/user/presentation/widgets/image_picker_button.dart';
import 'package:image_picker/image_picker.dart';  // Importa el paquete image_picker
import 'dart:typed_data';

import 'package:loging_app/injection_container.dart'; // Para trabajar con Uint8List

class CreateProfileScreen extends StatelessWidget  {
  const CreateProfileScreen({super.key});

 
//escucha pantalla
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateProfileBloc(createProfileUseCase: serviceLocator<CreateProfileUseCase>()),
      child: const CreateProfileContent(),
    );
  }
}

//Widget que contiene el contenido de la pantalla
class CreateProfileContent extends StatefulWidget {
  const CreateProfileContent({super.key});
  @override
  _CreateProfileContentState createState() => _CreateProfileContentState();
}


class _CreateProfileContentState extends State<CreateProfileContent> {
  // Inicialización de las variables
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final bool _isAvailable = true; // Valor predeterminado

//Libera recursos cuando ya no son utilizados
@override
void dispose() {
  _nameFocusNode.dispose();
  _emailFocusNode.dispose();
  _passwordFocusNode.dispose();
  super.dispose();
}

  final List<String> _userTypes = ['Vendedor', 'Cliente'];
  String? _selectedUserType;
  Uint8List? _profileImageBytes;  // Para almacenar los bytes de la imagen

  // Método para seleccionar imagen desde el sistema de archivos
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();  // Lee los bytes de la imagen
      setState(() {
        _profileImageBytes = bytes;  // Asigna los bytes a la variable
      });
    }
  }

// Se configura la interfaz
  @override
Widget build(BuildContext context) {
  // BlocListener escucha el estado del BLoC y muestra un mensaje de error o éxito 
  return BlocListener<CreateProfileBloc, CreateProfileState>(
    listener: (context, state) {
  if (state is CreateProfileStateSucess) {

    Navigator.of(context, rootNavigator: true).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil creado correctamente')),
    );

    // Limpia los campos después de enviar
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _selectedUserType = null;
      _profileImageBytes = null;
    });

  } else if (state is DuplicateEmailFailureState) {
    // Manejo de correo duplicado
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('El correo electrónico ya está en uso.')),
    );
  } else if (state is InvalidDataFailureState) {
    // Manejo de datos inválidos
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Los datos ingresados no son válidos. Intenta nuevamente.')),
    );
  } else if (state is CreateProfileStateFailureState) {
    // Manejo de errores generales
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.error)),
    );
  }else if (state is CreateProfileStateLoading) {
      // Mostrar diálogo de carga
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }
}
,
    child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                LogoHeader(
                  titulo: 'Crear Perfil',
                  onNavigateBack: () {
                    Navigator.pop(context);
                  },
                ),               
                const SizedBox(height: 16),

                // Aquí usas tu widget ImageDisplay
                  ImageDisplay(
                    imageBytes: _profileImageBytes, 
                  ),
                const SizedBox(height: 16),
                ImagePickerButton(
                  onPressed: _pickImage,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _nameController,
                  labelText: 'Nombre',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _emailController,
                  labelText: 'Correo Electrónico',
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
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Contraseña',
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
                const SizedBox(height: 20),
                
                CustomDropdownField<String>(
                  labelText: 'Tipo de Usuario',
                  items: _userTypes,
                  selectedValue: _selectedUserType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedUserType = newValue;
                          print('Selected User Type: $_selectedUserType');  // Verificar el valor seleccionado

                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecciona el tipo de usuario';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// botón que valida el formulario y dispara el evento CreateProfileButtonPressed 
  Widget _buildSubmitButton() {
  return ElevatedButton(
    onPressed: () {
      if (_profileImageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecciona una imagen de perfil')),
        );
        return;
      }

      if (_formKey.currentState?.validate() == true) {
        // Envía los datos al Bloc al hacer clic en "Crear Perfil"
        context.read<CreateProfileBloc>().add(

          CreateProfileButtonPressed(            
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            userType: _selectedUserType!,
            photo: _profileImageBytes!,  // Aquí enviamos la imagen en base64       
             disponibility: _isAvailable,     
             location: '',  
          ),          
        );        
      }
    },
    child: const Text('Crear Perfil'),
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFDC6B27),  // Color de fondo del botón
      foregroundColor: Colors.white,
    ),
  );
}

}
