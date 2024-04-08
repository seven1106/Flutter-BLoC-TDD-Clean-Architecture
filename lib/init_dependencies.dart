import 'package:flutter_tdd_clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_tdd_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'core/secrets/app_secrets.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_iml.dart';
import 'features/auth/domain/usecase/current_user.dart';
import 'features/auth/domain/usecase/user_sign_in.dart';
import 'features/auth/domain/usecase/user_sign_up.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuthDependencies();
  final supaBase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
    debug: true,
  );
  serviceLocator.registerLazySingleton(() => supaBase.client);
}

void _initAuthDependencies() {
  // DataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    // UseCases
    ..registerFactory(
      () => UserSignUpUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignInUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUserUseCase(
        serviceLocator(),
      ),
    )
    // Core
    ..registerLazySingleton(
      () => AppUserCubit(
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
