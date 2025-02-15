import 'package:flutter/material.dart';
import 'package:loging_app/core/utils/routes.dart';
import 'package:loging_app/features/order/presentation/bloc/order_details_bloc/order_details_bloc.dart';
import 'package:loging_app/features/product/presentation/bloc/edit_product/edit_product_bloc.dart';
import 'package:loging_app/features/product/presentation/bloc/placer_order/place_order_bloc.dart';
import 'package:loging_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:loging_app/features/user/presentation/bloc/create_profile/create_profile_bloc.dart';
import 'package:loging_app/injection_container.dart' as di;
import 'package:loging_app/features/user/presentation/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/order/presentation/bloc/pending_orders_bloc/pending_orders_bloc.dart';
import 'features/product/presentation/bloc/product_offered_bloc/product_offered_bloc.dart';
import 'features/product/presentation/bloc/product_seller_bloc/products_seller_bloc.dart';
import 'features/user/presentation/bloc/login_user/login_user_bloc.dart';
import 'features/user/presentation/bloc/update_avalability/user_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await di.init();
  runApp(
    MultiBlocProvider(
  providers: [
    BlocProvider<CreateProfileBloc>(
      create: (_) => CreateProfileBloc(createProfileUseCase: di.serviceLocator()),
    ),
    BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(loginUserUseCase: di.serviceLocator()),
    ),
    BlocProvider<EditProfileBloc>(
      create: (_) => EditProfileBloc(editProfileUseCase: di.serviceLocator()),
    ),
    BlocProvider<ProductBloc>(
      create: (_) => ProductBloc(getProducts: di.serviceLocator()),
    ),
    BlocProvider<ProductsSellerBloc>(
      create: (_) => ProductsSellerBloc(getProductsSellerUseCase: di.serviceLocator()),
    ),
    BlocProvider<UserCubit>(
      create: (_) => UserCubit(),
    ),
    BlocProvider<PendingOrdersBloc>(
      create: (_) => PendingOrdersBloc(getPendingOrders: di.serviceLocator()),
    ),
    BlocProvider<OrderDetailsBloc>(
      create: (_) => OrderDetailsBloc(getOrderProduct: di.serviceLocator()),
    ),
    BlocProvider<PlaceOrderBloc>(
      create: (_) => PlaceOrderBloc(di.serviceLocator()),
    ),
    BlocProvider<ProductOfferedBloc>(
  create: (_) => ProductOfferedBloc(getProductsOfferedUseCase: di.serviceLocator()),
    ),
    BlocProvider<EditProductBloc>(
  create: (_) => EditProductBloc(updateProductUseCase: di.serviceLocator()),
    ),
  ],
  child: const MyApp(),

    )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.getRoutes(),
    );
  }
}