import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart';
import 'package:loging_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:loging_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:loging_app/features/product/domain/repositories/product_repository.dart';
import 'package:loging_app/features/product/domain/use_cases/add_product_use_case.dart';
import 'package:loging_app/features/product/domain/use_cases/get_products.dart';
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
import 'features/user/domain/use_cases/update_availability_use_case.dart';

final serviceLocator = GetIt.instance;
String apiUrl = 'http://localhost:3000';

Future<void> init() async {
  initInjections();
}

void initInjections() {
  // Repositorio de usuarios
  serviceLocator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(serviceLocator()));

  // Cliente gRPC
  serviceLocator.registerLazySingleton<ClientChannel>(() => ClientChannel(
        'localhost',
        port: 50051,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()),
      ));

  // DataSource para productos (gRPC)
  serviceLocator.registerLazySingleton<ProductRemoteDataSource>(() =>
      ProductRemoteDataSourceImpl(serviceLocator<ClientChannel>(),
          apiUrl: apiUrl));

  // DataSource para usuarios
  serviceLocator.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(apiUrl : apiUrl));

  // Casos de uso para usuarios
  serviceLocator.registerLazySingleton<LoginUserUseCase>(
      () => LoginUserUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton<CreateProfileUseCase>(
      () => CreateProfileUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton<EditProfileUseCase>(
      () => EditProfileUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton<UpdateAvailabilityUseCase>(
      () => UpdateAvailabilityUseCase(repository: serviceLocator()));

  // Repositorio de productos (gRPC)
  serviceLocator.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(serviceLocator<ProductRemoteDataSource>()));

  // Caso de uso para obtener productos (gRPC)
  serviceLocator.registerLazySingleton<GetProducts>(
      () => GetProducts(repository: serviceLocator<ProductRepository>()));

  // DataSource para productos (REST)
  serviceLocator.registerLazySingleton<ProductRemoteDataSourceRest>(
      () => ProductRemoteDataSourceRestImpl(apiUrl: apiUrl)
  );

  // Repositorio de productos (REST)
  serviceLocator.registerLazySingleton<ProductRestRepository>(() =>
      ProductRestRepositoryRestImpl(
          serviceLocator<ProductRemoteDataSourceRest>()));

  // Casos de uso para obtener productos ofrecidos (REST)
  serviceLocator.registerLazySingleton<GetProductsOfferedUseCase>(() =>
      GetProductsOfferedUseCase(
          repositoryProduct: serviceLocator<ProductRestRepository>()));

  // Casos de uso para obtener productos del vendedor (REST)
  serviceLocator.registerLazySingleton<GetProductsSellerUseCase>(() =>
      GetProductsSellerUseCase(
          repositoryProduct: serviceLocator<ProductRestRepository>()));

  // Caso de uso para agregar productos
  serviceLocator.registerLazySingleton<AddProductUseCase>(
      () => AddProductUseCase(repository: serviceLocator()));

  // Registrar el caso de uso PlaceOrderUseCase
  serviceLocator.registerLazySingleton<PlaceOrderUseCase>(
      () => PlaceOrderUseCase(repository: serviceLocator<ProductRepository>()));
}
