import 'package:get_it/get_it.dart';
import 'package:loging_app/features/user/data/datasources/user_remote_data_source.dart';
import 'package:loging_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:loging_app/features/user/domain/repositories/user_repository.dart';
import 'package:loging_app/features/user/domain/use_cases/login_user_use_case.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async{
  initInjections();
}

void initInjections(){
  serviceLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(serviceLocator())
  );

  serviceLocator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl()
  );

  serviceLocator.registerLazySingleton<LoginUserUseCase>(
    () => LoginUserUseCase(repository: serviceLocator())// Aquí se inyecta el repositorio que se registró arriba
  );

  
}
