import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:loging_app/core/utils/session.dart';
import 'package:loging_app/features/user/domain/repositories/user_repository.dart';
import 'package:loging_app/features/user/domain/use_cases/delete_profile_use_case.dart';
import 'package:loging_app/features/user/domain/use_cases/edit_profile_use_case.dart';
import 'package:loging_app/features/user/presentation/bloc/Edit_profile/edit_profile_bloc.dart';
import 'package:loging_app/features/user/presentation/bloc/Edit_profile/edit_profile_event.dart';
import 'package:loging_app/features/user/presentation/bloc/Edit_profile/edit_profile_state.dart';
import 'package:loging_app/features/user/presentation/bloc/delete_profile/delete_profile_bloc.dart';
import 'package:loging_app/features/user/presentation/widgets/custom_text_field.dart';
import 'package:loging_app/features/user/presentation/widgets/header_logo.dart';
import 'package:loging_app/features/user/presentation/widgets/image_display.dart';
import 'package:loging_app/features/user/presentation/widgets/image_picker_button.dart';
import 'package:loging_app/injection_container.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileBloc(
        editProfileUseCase: serviceLocator<EditProfileUseCase>(),
      ),
      child: BlocProvider(
        create: (_) => DeleteProfileBloc(
          deleteProfileUseCase: serviceLocator<DeleteProfileUseCase>(),
        ),
      
      child: const EditProfileContent(),
      ),
    );
  }
}

class EditProfileContent extends StatefulWidget {
  const EditProfileContent({super.key});

  @override
  _EditProfileContentState createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<EditProfileContent> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _profileImageBytes;

  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    final user = Session.instance.user;
    if (user != null) {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _passwordController.text = user.password;
      _profileImageBytes = user.photo;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _profileImageBytes = bytes;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al seleccionar la imagen: $e')),
      );
    }
  }

  void _updateProfile() {
  if (_profileImageBytes == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor, selecciona una imagen de perfil')),
    );
    return;
  }

  if (_formKey.currentState?.validate() == true) {
    context.read<EditProfileBloc>().add(
      EditProfileButtonPressed(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        profileImage: _profileImageBytes!,
      ),
    );
  }
}


  void _deleteProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Perfil'),
        content: const Text(
          '¿Estás seguro de que deseas eliminar tu perfil? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              try {
                final userRepository = serviceLocator<UserRepository>();
                await userRepository.deleteUser();
                Session.instance.endSession();
                Navigator.pushNamed(context, '/login');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Perfil eliminado exitosamente')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al eliminar el perfil: $e')),
                );
              }
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileStateSucess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Perfil actualizado correctamente')),
          );
          // Cierra la sesión y navega al login después de un retraso
          Future.delayed(const Duration(seconds: 1), () {
                Session.instance.endSession();
                Navigator.pushReplacementNamed(context, '/login');
              });

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
                    onNavigateBack: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 16),
                  if (_profileImageBytes != null)
                    ImageDisplay(imageBytes: _profileImageBytes),
                  const SizedBox(height: 16),
                  ImagePickerButton(onPressed: _pickImage),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _nameController,
                    labelText: 'Nombre',
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Por favor, ingresa tu nombre' : null,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _updateProfile,
                        child: const Text('Editar Perfil'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _deleteProfile,
                        child: const Text('Eliminar Perfil'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
