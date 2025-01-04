import 'package:flutter/material.dart';
import 'package:loging_app/core/utils/routes.dart';
import 'package:loging_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:loging_app/features/user/presentation/bloc/create_profile/create_profile_bloc.dart';
import 'package:loging_app/injection_container.dart' as di;
import 'package:loging_app/features/user/presentation/bloc/edit_profile/edit_profile_bloc.dart';

import 'features/product/presentation/bloc/product_offered_bloc/product_offered_bloc.dart';
import 'features/user/presentation/bloc/login_user/login_user_bloc.dart';
import 'package:provider/provider.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        Provider<CreateProfileBloc>(create: (_) => CreateProfileBloc(createProfileUseCase: di.serviceLocator())),
        Provider<LoginBloc>(create: (_) => LoginBloc(loginUserUseCase: di.serviceLocator())),
        Provider<EditProfileBloc>(create: (_) => EditProfileBloc(editProfileUseCase: di.serviceLocator())),
        Provider<ProductBloc>(create: (_) => ProductBloc(getProducts: di.serviceLocator())),
        Provider<ProductOfferedBloc>(create: (_) => ProductOfferedBloc(getProductsOfferedUseCase: di.serviceLocator()))

      ],
      child:  const MyApp(),
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