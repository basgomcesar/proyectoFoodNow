import 'package:flutter/material.dart';
import 'package:loging_app/core/utils/routes.dart';
import 'package:loging_app/injection_container.dart' as di;
import 'package:provider/provider.dart';

import 'features/user/presentation/bloc/login_user/login_user_bloc.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        Provider<LoginBloc>(create: (_) => LoginBloc(loginUserUseCase: di.serviceLocator())),
      ],
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange,),
      initialRoute:  AppRoutes.login,
      routes: AppRoutes.getRoutes(),
    );
  }
}