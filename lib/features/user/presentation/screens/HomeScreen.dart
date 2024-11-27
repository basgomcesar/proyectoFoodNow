import 'package:flutter/material.dart';
import 'package:loging_app/features/user/presentation/widgets/header_logo.dart';
import 'package:loging_app/features/user/presentation/widgets/list_view.dart';
import 'package:provider/provider.dart';
import 'package:loging_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:loging_app/features/product/presentation/screens/ProductListView.dart';
import 'package:loging_app/injection_container.dart' as di;

class HomeScreen extends StatefulWidget {
  final String email;

  const HomeScreen({super.key, required this.email});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

//@override
//void initState() {
  /* super.initState();
    context.read<AvailabilityBloc>().add(AvailabilityButtonPressed(
              userId: "4"),
      );
  }*/

  @override
  Widget build(BuildContext context) {
    return Provider<ProductBloc>(
      create: (_) => ProductBloc(getProducts: di.serviceLocator()),
      child: Scaffold(
        appBar: AppBar(
  title: const LogoHeader(
    titulo: 'Lista de productos',
  ),
        ),
        drawer: Drawer(
          child: DrawerListView(email: widget.email),
        ),
        body: const ProductListScreen(),
      ),

    );
  }
}