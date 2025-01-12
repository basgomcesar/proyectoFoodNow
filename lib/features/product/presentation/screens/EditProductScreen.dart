import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/product/data/models/product_model.dart';
import 'package:loging_app/features/product/domain/use_cases/update_product_use_case.dart';
import 'package:loging_app/features/product/presentation/bloc/edit_product/edit_product_bloc.dart';
import 'package:loging_app/features/user/presentation/widgets/custom_text_field.dart';
import 'package:loging_app/injection_container.dart';

class EditProductScreen extends StatelessWidget {
  final ProductModel product;

  const EditProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProductBloc(updateProductUseCase: serviceLocator<UpdateProductUseCase>()),
      child: EditProductContent(product: product),
    );
  }
}

class EditProductContent extends StatefulWidget {
  final ProductModel product;

  const EditProductContent({super.key, required this.product});

  @override
  _EditProductContentState createState() => _EditProductContentState();
}

class _EditProductContentState extends State<EditProductContent> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _availableQuantityController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.product.description ?? '');
    _priceController = TextEditingController(text: widget.product.price.toString());
    _availableQuantityController = TextEditingController(text: widget.product.quantityAvailable.toString());
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _priceController.dispose();
    _availableQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProductBloc, EditProductState>(
      listener: (context, state) {
        if (state is EditProductSuccessState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Producto actualizado correctamente')),
          );
          Navigator.pushNamed(context, '/home');
        } else if (state is EditProductFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state is EditProductLoadingState) {
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
        appBar: AppBar(
          title: const Text('Editar Producto'),
          backgroundColor: const Color(0xFFDC6B27),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Información no editable
                  Text(
                    'Nombre del Producto: ${widget.product.name}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Categoría: ${widget.product.category ?? 'Sin categoría'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Disponibilidad: ${widget.product.available ? "Disponible" : "No disponible"}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const Divider(),

                  // Campos editables
                  CustomTextField(
                    controller: _descriptionController,
                    labelText: 'Descripción del producto',
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
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa el precio unitario';
                      }
                      final double? price = double.tryParse(value);
                      if (price == null || price <= 0) {
                        return 'El precio debe ser mayor que cero';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _availableQuantityController,
                    labelText: 'Cantidad disponible',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa la cantidad disponible';
                      }
                      final int? quantity = int.tryParse(value);
                      if (quantity == null || quantity <= 0) {
                        return 'La cantidad debe ser mayor que cero';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        context.read<EditProductBloc>().add(
                          EditProductButtonPressed(
                            product: widget.product.copyWith(
                              description: _descriptionController.text,
                              price: double.parse(_priceController.text),
                              quantityAvailable: int.parse(_availableQuantityController.text),
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Actualizar Producto'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC6B27),
                      foregroundColor: Colors.white,
                    ),
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
