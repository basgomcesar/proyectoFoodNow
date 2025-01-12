import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart';
import 'package:loging_app/features/order/data/datasources/order_remote_data_source.dart';
import 'package:loging_app/features/order/data/repositories/products_order_repository_impl.dart';
import 'package:loging_app/features/order/domain/repositories/products_order_repository.dart';
import 'package:loging_app/features/order/domain/use_cases/cancel_order.dart';
import 'package:loging_app/features/order/domain/use_cases/confirm_order.dart';
import 'package:loging_app/features/order/domain/use_cases/get_customer_orders.dart';
import 'package:loging_app/features/order/domain/use_cases/get_pending_orders.dart';
import 'package:loging_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:loging_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:loging_app/features/product/domain/repositories/product_repository.dart';
import 'package:loging_app/features/product/domain/use_cases/add_product_use_case.dart';
import 'package:loging_app/features/product/domain/use_cases/delete_product_use_case.dart';
import 'package:loging_app/features/product/domain/use_cases/get_order_product.dart';
import 'package:loging_app/features/product/domain/use_cases/get_products.dart';
import 'package:loging_app/features/product/domain/use_cases/update_product_use_case.dart';
import 'package:loging_app/features/product/domain/use_cases/place_order_use_case.dart';
import 'package:loging_app/features/user/data/datasources/user_remote_data_source.dart';
import 'package:loging_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:loging_app/features/user/domain/repositories/user_repository.dart';
import 'package:loging_app/features/user/domain/use_cases/create_profile_use_case.dart';
import 'package:loging_app/features/user/domain/use_cases/edit_profile_use_case.dart';
import 'package:loging_app/features/user/domain/use_cases/login_user_use_case.dart';

import 'features/product/data/datasources/product_remote_data_source_rest.dart';
import 'features/product/data/repositories/product_repository_rest_impl.dart';
import 'features/product/domain/repositories/product_rest_repository.dart';
import 'features/product/domain/use_cases/get_products_offered_use_case.dart';
import 'features/product/domain/use_cases/get_products_seller_use_case.dart';
import 'features/product/presentation/bloc/product_offered_bloc/product_offered_bloc.dart';
import 'features/user/domain/use_cases/update_availability_use_case.dart';

final serviceLocator = GetIt.instance;
String apiUrl = 'http://192.168.100.40:3000';

Future<void> init() async {
  initInjections();
}

void initInjections() {
  // Repositorio de usuarios
  serviceLocator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(serviceLocator()));

  // Cliente gRPC
  serviceLocator.registerLazySingleton<ClientChannel>(() => ClientChannel(
    '192.168.100.40',
    port: 50051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  ));

  // DataSource para productos (gRPC)
  serviceLocator.registerLazySingleton<ProductRemoteDataSource>(() =>
      ProductRemoteDataSourceImpl(serviceLocator<ClientChannel>(), apiUrl: apiUrl));

  // DataSource para usuarios
  serviceLocator.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(apiUrl: apiUrl));

  // Casos de uso para usuarios
  serviceLocator.registerLazySingleton<LoginUserUseCase>(() => LoginUserUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton<CreateProfileUseCase>(() => CreateProfileUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton<EditProfileUseCase>(() => EditProfileUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton<UpdateAvailabilityUseCase>(() => UpdateAvailabilityUseCase(repository: serviceLocator()));

  // Repositorio de productos (gRPC)
  serviceLocator.registerLazySingleton<ProductRepository>(() =>
      ProductRepositoryImpl(serviceLocator<ProductRemoteDataSource>()));

  // Caso de uso para obtener productos (gRPC)
  serviceLocator.registerLazySingleton<GetProducts>(() =>
      GetProducts(repository: serviceLocator<ProductRepository>()));

  serviceLocator.registerLazySingleton<ProductRemoteDataSourceRest>(() =>
        ProductRemoteDataSourceRestImpl(apiUrl: apiUrl));

serviceLocator.registerLazySingleton<ProductOfferedBloc>(() =>
    ProductOfferedBloc(getProductsOfferedUseCase: serviceLocator<GetProductsOfferedUseCase>()));


  // Repositorio de productos (REST)
  serviceLocator.registerLazySingleton<ProductRestRepository>(() =>
      ProductRestRepositoryRestImpl(serviceLocator<ProductRemoteDataSourceRest>()));

  // Casos de uso para obtener productos ofrecidos (REST)
  serviceLocator.registerLazySingleton<GetProductsOfferedUseCase>(() =>
      GetProductsOfferedUseCase(repositoryProduct: serviceLocator<ProductRestRepository>()));

  // Casos de uso para obtener productos del vendedor (REST)
  serviceLocator.registerLazySingleton<GetProductsSellerUseCase>(() =>
      GetProductsSellerUseCase(repositoryProduct: serviceLocator<ProductRestRepository>()));

  // Caso de uso para agregar productos
  serviceLocator.registerLazySingleton<AddProductUseCase>(() =>
      AddProductUseCase(repository: serviceLocator()));

  // Registrar el caso de uso PlaceOrderUseCase
  serviceLocator.registerLazySingleton<PlaceOrderUseCase>(() =>
      PlaceOrderUseCase(repository: serviceLocator<ProductRepository>()));

  serviceLocator.registerLazySingleton<GetOrderProduct>(() =>
      GetOrderProduct(repository: serviceLocator()));

  serviceLocator.registerLazySingleton<OrderRemoteDataSource>(() => OrderRemoteDataSourceImpl(apiUrl: apiUrl));

  serviceLocator.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(serviceLocator()));

  serviceLocator.registerLazySingleton<GetPendingOrdersUseCase>(() =>
      GetPendingOrdersUseCase(serviceLocator<OrderRepository>()));

  serviceLocator.registerLazySingleton<GetCustomerOrdersUseCase>(() =>
      GetCustomerOrdersUseCase(serviceLocator<OrderRepository>()));

  serviceLocator.registerLazySingleton<CancelOrderUseCase>(() =>
      CancelOrderUseCase(repository: serviceLocator()));

  serviceLocator.registerLazySingleton<ConfirmOrderUseCase>(() =>
      ConfirmOrderUseCase(repository: serviceLocator()));

  serviceLocator.registerLazySingleton<UpdateProductUseCase>(() =>
      UpdateProductUseCase(repository: serviceLocator()));

  serviceLocator.registerLazySingleton<DeleteProductUseCase>(() =>
      DeleteProductUseCase(repository: serviceLocator()));
}
