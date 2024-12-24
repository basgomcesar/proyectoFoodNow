import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/user/presentation/bloc/update_avalability/update_availability_bloc.dart';
import 'package:loging_app/features/user/presentation/bloc/update_avalability/update_availability_event.dart';
import 'package:loging_app/injection_container.dart';
import '../../../../core/utils/session.dart';
import '../../domain/use_cases/update_availability_use_case.dart';

class ChangeAvailability extends StatelessWidget {
  const ChangeAvailability({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AvailabilityBloc(availabilityUseCase: serviceLocator<UpdateAvailabilityUseCase>()),
      child: const AvailabilityContent(),
    );
  }
}

class AvailabilityContent extends StatefulWidget {
  const AvailabilityContent({super.key});

  @override
  _AvailabilityContent createState() => _AvailabilityContent();
}

class _AvailabilityContent extends State<AvailabilityContent> {
  // Controladores de texto
  final TextEditingController _locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FocusNode _availabilityFocusNode = FocusNode();
  final FocusNode _locationFocusNode = FocusNode();
  bool isAvailable = false; // Estado inicial del switch

  @override
  void dispose() {
    _availabilityFocusNode.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Cargar los datos del usuario desde la sesión
    final user = Session.instance.user;
    if (user != null) {
      isAvailable = user.disponibility;
      _locationController.text = user.location;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurar Disponibilidad y Ubicación"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isAvailable ? "Disponible" : "No disponible",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Switch(
                    value: isAvailable,
                    onChanged: (value) {
                      setState(() {
                        isAvailable = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Ubicación",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _locationController,
                focusNode: _locationFocusNode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Ingrese la ubicación",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, ingrese su ubicación";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      // Envía los datos al Bloc
                      context.read<AvailabilityBloc>().add(
                        AvailabilityButtonPressed(
                          availability: isAvailable,
                          location: _locationController.text,
                        ),
                      );

                      // Mostrar mensaje de éxito
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cambios guardados con éxito'),
                        ),
                      );
                    }
                  },
                  child: const Text('Guardar Cambios'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}