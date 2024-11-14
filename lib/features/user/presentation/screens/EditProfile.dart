import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/user/domain/use_cases/edit_profile_use_case.dart';
import 'package:loging_app/features/user/presentation/bloc/Edit_profile/edit_profile_bloc.dart';
import 'package:loging_app/features/user/presentation/bloc/Edit_profile/edit_profile_event.dart';
import 'package:loging_app/features/user/presentation/bloc/Edit_profile/edit_profile_state.dart';
import 'package:loging_app/features/user/presentation/widgets/custom_text_field.dart';
import 'package:loging_app/features/user/presentation/widgets/header_logo.dart';
import 'package:loging_app/features/user/presentation/widgets/image_picker_button.dart';
import 'package:image_picker/image_picker.dart';  // Importa el paquete image_picker
import 'dart:typed_data';

import 'package:loging_app/injection_container.dart'; // Para trabajar con Uint8List

class EditProfile extends StatelessWidget  {
  const EditProfile({super.key});

 
//escucha pantalla
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileBloc(editProfileUseCase: serviceLocator<EditProfileUseCase>()),
      child: const EditProfileContent(),
    );
  }
}

//Widget que contiene el contenido de la pantalla
class EditProfileContent extends StatefulWidget {
  const EditProfileContent({super.key});
  @override
  _EditProfileContentState createState() => _EditProfileContentState();
}


class _EditProfileContentState extends State<EditProfileContent> {
  // Inicialización de las variables
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

//Libera recursos cuando ya no son utilizados
@override
void dispose() {
  _nameFocusNode.dispose();
  _emailFocusNode.dispose();
  _passwordFocusNode.dispose();
  super.dispose();
}

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
  return BlocListener<EditProfileBloc, EditProfileState>(
    listener: (context, state) {
      if (state is EditProfileStateSucess) {
        //Muestra mensaje de éxito   
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perfil actualizado correctamente')),
        );     
      } else if (state is EditProfileStateFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error)),
        );
      }
    },
    child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                LogoHeader(
                  titulo: 'Editar Perfil',
                  onNavigateBack: () {
                    Navigator.pop(context);
                  },
                ),
                if (_profileImageBytes != null)
                  Image.memory(
                    _profileImageBytes!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
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
        // Convertir los bytes de la imagen a base64
        String base64Image = base64Encode(_profileImageBytes!);

        // Envía los datos al Bloc al hacer clic en "Crear Perfil"
        context.read<EditProfileBloc>().add(

          EditProfileButtonPressed(            
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            profileImage: base64Image,  // Aquí enviamos la imagen en base64       
          ),          
        );

        // Limpia los campos después de enviar
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
        setState(() {
          _profileImageBytes = null;
        });
      }
    },
    child: const Text('Editar Perfil'),
  );
}

}
