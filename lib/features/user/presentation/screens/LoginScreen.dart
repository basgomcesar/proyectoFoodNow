import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/features/user/domain/use_cases/login_user_use_case.dart';
import 'package:loging_app/features/user/presentation/bloc/login_user/login_user_bloc.dart';
import 'package:loging_app/features/user/presentation/bloc/login_user/login_user_event.dart';
import 'package:loging_app/features/user/presentation/bloc/login_user/login_user_state.dart';
import 'package:loging_app/injection_container.dart';
import 'package:loging_app/features/user/presentation/widgets/logo_widget.dart';
import 'package:loging_app/features/user/presentation/widgets/email_field_widget.dart';
import 'package:loging_app/features/user/presentation/widgets/password_field_widget.dart';
import 'package:loging_app/features/user/presentation/widgets/actions_buttons.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(loginUserUseCase: serviceLocator<LoginUserUseCase>()),
      child: const LoginScreenContent(),
    );
  }
}

class LoginScreenContent extends StatefulWidget {
  const LoginScreenContent({super.key});
  @override
  _LoginScreenContentState createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<LoginScreenContent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_handleFocusChange);
    _passwordFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isKeyboardVisible = _emailFocusNode.hasFocus || _passwordFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }


  void _login(BuildContext context) {
    if (_formKey.currentState?.validate() == true) {
      context.read<LoginBloc>().add(
            LoginButtonPressed(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushNamed(context, '/home');
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                  child: _buildForm(context),
                ),
                if (state is LoginLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildIniciarSesionLabel() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: const Text(
        'Iniciar sesión',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LogoWidget(isVisible: _isKeyboardVisible),
          _buildIniciarSesionLabel(),
          EmailField(controller: _emailController, focusNode: _emailFocusNode),
          PasswordField(controller: _passwordController, focusNode: _passwordFocusNode),
          ActionButtons(
            onLoginPressed: () => _login(context),
            onCreateAccountPressed: () => _createAccount(context),
          ),
        ],
      ),
    );
  }
  
  void _createAccount(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

}
