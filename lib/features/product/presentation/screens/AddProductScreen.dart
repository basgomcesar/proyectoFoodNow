import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/product/domain/use_cases/add_product_use_case.dart';
import 'package:loging_app/features/product/presentation/bloc/add_product/add_product_bloc.dart';
import 'package:loging_app/features/product/presentation/bloc/add_product/add_product_event.dart';
import 'package:loging_app/features/product/presentation/bloc/add_product/add_product_state.dart';
import 'package:loging_app/features/user/presentation/widgets/custom_text_field.dart';
import 'package:loging_app/features/user/presentation/widgets/header_logo.dart';
import 'package:loging_app/features/user/presentation/widgets/custom_dropdown_field.dart';
import 'package:loging_app/features/user/presentation/widgets/image_display.dart'; 
import 'package:loging_app/features/user/presentation/widgets/image_picker_button.dart';
import 'package:image_picker/image_picker.dart';  // Importa el paquete image_picker
import 'dart:typed_data';

import 'package:loging_app/injection_container.dart'; // Para trabajar con Uint8List

class AddProductScreen extends StatelessWidget  {
  const AddProductScreen({super.key});

 
//escucha pantalla
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddProductBloc(addProductUseCase: serviceLocator<AddProductUseCase>()),
      child: const AddProductContent(),
    );
  }
}


//Widget que contiene el contenido de la pantalla
  class AddProductContent extends StatefulWidget {
    const AddProductContent({super.key});
    @override
    _AddProductContentState createState() => _AddProductContentState();
  }

  class _AddProductContentState extends State<AddProductContent> {
  // Inicialización de las variables
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _availableQuantityController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode  _descriptionFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _availableQuantityFocusNode = FocusNode();
  final bool _isAvailable = true; // Valor predeterminado 

  //Libera recursos cuando ya no son utilizados
  @override
  void dispose() {
    _nameFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _availableQuantityFocusNode.dispose();
    super.dispose();
  }

  final List<String> _productTypes = ['Comida', 'Dulce', 'Bebida', 'Botana', 'Postre'];
  String? _selectedProductType;
  Uint8List? _ProductImageBytes;  // Para almacenar los bytes de la imagen

  // Método para seleccionar imagen desde el sistema de archivos
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();  // Lee los bytes de la imagen
      setState(() {
        _ProductImageBytes = bytes;  
      });
    }
  }

// Se configura la interfaz
  @override
Widget build(BuildContext context) {
  // BlocListener escucha el estado del BLoC y muestra un mensaje de error o éxito 
  return BlocListener<AddProductBloc, AddProductState>(
  listener: (context, state) {
    if (state is AddProductStateSucess) {
      Navigator.of(context, rootNavigator: true).pop(); // Cierra el diálogo de carga si está abierto
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto creado correctamente')),
      );

      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _availableQuantityController.clear();
      setState(() {
        _selectedProductType = null;
        _ProductImageBytes = null;
      });

    } else if (state is DuplicateProductFailureState) {
      Navigator.of(context, rootNavigator: true).pop(); // Cierra el diálogo
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ya tienes un producto con este nombre')),
      );

    } else if (state is InvalidPriceFailureState) {
      Navigator.of(context, rootNavigator: true).pop(); // Cierra el diálogo
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(
            'El precio ingresado es inválido. Debe ser un número con hasta 2 decimales.')),
      );
    } else if (state is InvalidDataFailureState) {
      Navigator.of(context, rootNavigator: true).pop(); // Cierra el diálogo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error)),
      );
    } else if (state is AddProductStateLoading) {
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
                  titulo: 'Agregar Producto',
                  onNavigateBack: () {
                    Navigator.pop(context);
                  },
                ),               
                const SizedBox(height: 16),

                  ImageDisplay(
                    imageBytes: _ProductImageBytes, 
                  ),
                  const SizedBox(height: 16),
                  ImagePickerButton(
                    onPressed: _pickImage,
                  ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _nameController,
                  labelText: 'Nombre del producto',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa un nombre ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _descriptionController, 
                  labelText: 'Descripción del producto',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa una descripción';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _priceController,
                  labelText: 'Precio unitario',
                  keyboardType: TextInputType.numberWithOptions(decimal: true), // Permite solo números con decimales
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')), // Permite solo números con hasta dos decimales
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa el precio unitario';
                    }
                    final RegExp priceRegex = RegExp(r'^\d+(\.\d{1,2})?$');
                    if (!priceRegex.hasMatch(value)) {
                      return 'El precio debe ser un número válido con hasta dos decimales';
                    }

                    // Convertir el valor a número
                    final double? price = double.tryParse(value);
                    if (price == null || price <= 0) {
                      return 'El precio debe ser mayor que cero';
                    }
                    return null;
                  },
                ),
                  const SizedBox(height: 20),

              CustomTextField(
                controller: _availableQuantityController,
                labelText: 'Cantidad disponible',
                keyboardType: TextInputType.number,  // Permite solo números
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Permite solo números enteros
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la cantidad disponible';
                  }
                  final RegExp quantityRegex = RegExp(r'^\d+$');  // Asegura que solo sea un número entero
                  if (!quantityRegex.hasMatch(value)) {
                    return 'La cantidad debe ser un número entero';
                  }
                  final int? quantity = int.tryParse(value);
                  if (quantity == null || quantity <= 0) {
                    return 'La cantidad debe ser mayor que cero';
                  }
                  return null;
                },
              ),

                  const SizedBox(height: 20),


                
                CustomDropdownField<String>(
                  labelText: 'Tipo de Producto',
                  items: _productTypes,
                  selectedValue: _selectedProductType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedProductType = newValue;
                          print('Selected User Type: $_selectedProductType');  // Verificar el valor seleccionado

                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecciona el tipo de producto';
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
      if (_ProductImageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecciona una imagen del producto')),
        );
        return;
      }

      if (_formKey.currentState?.validate() == true) {
        // Envía los datos al Bloc al hacer clic en "Crear Perfil"
        context.read<AddProductBloc>().add(

          AddProductButtonPressed(            
            name: _nameController.text,
            description: _descriptionController.text,
            price: double.parse(_priceController.text),
            photo: _ProductImageBytes!,
            availableQuantity: int.parse(_availableQuantityController.text),  // Aquí enviamos la imagen en base64       
             disponibility: _isAvailable,     
             category: _selectedProductType!,
          ),          
        );

      }
    },
    child: const Text('Crear Producto'),
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFDC6B27),  // Color de fondo del botón
      foregroundColor: Colors.white,
    ),
  );
}

}

