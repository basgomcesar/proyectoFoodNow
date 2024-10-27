import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loging_app/features/user/data/datasources/user_local_data_source.dart';
import 'package:loging_app/features/user/data/datasources/user_remote_data_source.dart';
import 'package:loging_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:loging_app/features/user/domain/use_cases/login_user_use_case.dart';
import "package:loging_app/features/user/presentation/bloc/login_user/login_user_bloc.dart"; // Asegúrate de importar tu BLoC
import 'package:loging_app/features/user/presentation/bloc/login_user/login_user_event.dart'; // Asegúrate de importar tus eventos
import 'package:loging_app/features/user/presentation/bloc/login_user/login_user_state.dart'; // Asegúrate de importar tus estados
import 'package:loging_app/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Asegúrate de importar tus estados

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isKeyboardVisible = false;
  LoginBloc _loginBloc =
      LoginBloc(loginUserUseCase: serviceLocator<LoginUserUseCase>());

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_handleFocusChange);
    _passwordFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isKeyboardVisible =
          _emailFocusNode.hasFocus || _passwordFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginBloc =
        LoginBloc(loginUserUseCase: serviceLocator<LoginUserUseCase>());
  }

  Widget _buildLogo() {
    return _isKeyboardVisible
        ? const SizedBox.shrink()
        : SvgPicture.asset(
            'assets/loginIcon.svg',
            width: 200,
            height: 200,
          );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: const InputDecoration(
        labelText: 'Correo electrónico',
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

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: const InputDecoration(
        labelText: 'Contraseña',
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

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _login,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(
                220, 107, 39, 1), // Set the button color to orange
          ),
          child: const Text('Iniciar sesión',
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1), fontSize: 15)),
        ),
        const SizedBox(height: 20),
        _buildCreateAccountLabel(),
      ],
    );
  }

// ElevatedButton(
//           onPressed: () {
//             Navigator.pushNamed(context, '/createProfile');
//           },
//           child: _buildCreateAccountLabel(),
//         )
  void _login() {
    if (_formKey.currentState?.validate() == true) {
      final email = _emailController.text;
      final password = _passwordController.text;
      print("Aqui se debe llamar al método de login del BLoC");
      context.read<LoginBloc>().add(LoginButtonPressed(
          email: email,
          password:
              password)); // Aquí se llama al evento de login del BLoC con los datos del formulario
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _loginBloc,
      child: BlocListener(
        bloc: _loginBloc,
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushNamed(context, '/home');
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is LoginLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Cargando...")),
            );
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildIniciarSesionLabel() {
    return const Text(
      'Iniciar sesión',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildLogo(),
          const SizedBox(height: 20),
          _buildIniciarSesionLabel(),
          const SizedBox(height: 20),
          _buildEmailField(),
          const SizedBox(height: 20),
          _buildPasswordField(),
          const SizedBox(height: 20),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildCreateAccountLabel() {
    //Label ¿No tienes una cuenta? and the button to create an account
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('¿No tienes una cuenta?'),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/createProfile');
          },
          child: const Text(
            'Crear cuenta',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
