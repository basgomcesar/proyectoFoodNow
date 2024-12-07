import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart';
import 'package:loging_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:loging_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:loging_app/features/product/domain/repositories/product_repository.dart';
import 'package:loging_app/features/product/domain/use_cases/get_products.dart';
import 'package:loging_app/features/user/data/datasources/user_remote_data_source.dart';
import 'package:loging_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:loging_app/features/user/domain/repositories/user_repository.dart';
import 'package:loging_app/features/user/domain/use_cases/add_product_use_case.dart';
import 'package:loging_app/features/user/domain/use_cases/create_profile_use_case.dart';
import 'package:loging_app/features/user/domain/use_cases/edit_profile_use_case.dart';
import 'package:loging_app/features/user/domain/use_cases/login_user_use_case.dart';
import 'package:loging_app/features/user/presentation/bloc/update_avalability/update_availability_event.dart';

import 'features/user/domain/use_cases/update_availability_use_case.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  initInjections();
}

void initInjections() {
  serviceLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(serviceLocator())
  );

  serviceLocator.registerLazySingleton<ClientChannel>(
    () => ClientChannel(
      'localhost',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    )
  );

  serviceLocator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(serviceLocator<ClientChannel>())
  );

  serviceLocator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl()
  );

  serviceLocator.registerLazySingleton<LoginUserUseCase>(
    () => LoginUserUseCase(repository: serviceLocator())
  );

  serviceLocator.registerLazySingleton<CreateProfileUseCase>(
    () => CreateProfileUseCase(repository: serviceLocator())
  );

  serviceLocator.registerLazySingleton<EditProfileUseCase>(
    () => EditProfileUseCase(repository: serviceLocator())
  );

  serviceLocator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(serviceLocator<ProductRemoteDataSource>())
  );

  serviceLocator.registerLazySingleton<GetProducts>(
    () => GetProducts(repository: serviceLocator<ProductRepository>())
  );

  serviceLocator.registerLazySingleton<UpdateAvailabilityUseCase>(
    () => UpdateAvailabilityUseCase(repository: serviceLocator())
  );

  serviceLocator.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(repository: serviceLocator())
  );
}
