part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuthDependencies();
  _initBlogDependencies();
  final supaBase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
    debug: true,
  );
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogBox'));
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => supaBase.client);
  // serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator
      .registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(serviceLocator()));
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
        serviceLocator(),
        serviceLocator(),
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
      () => AppUserCubit(),
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

void _initBlogDependencies() {
  // DataSource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        client: serviceLocator(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
        () => BlogLocalDataSourceImpl(serviceLocator()))
    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        remoteDataSource: serviceLocator(),
        localDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )
    // UseCases
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        serviceLocator(),
      ),
    )

    // Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
