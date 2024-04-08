import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_tdd_clean_architecture/core/theme/theme.dart';
import 'package:flutter_tdd_clean_architecture/features/auth/presentation/pages/sign_in_page.dart';
import 'package:flutter_tdd_clean_architecture/init_dependencies.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<AppUserCubit>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthGetCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TDD Clean Architecture',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, state) {
          return state
              ? const Scaffold(body: Center(child: Text("Sign In")))
              : const SignInPage();
        },
      ),
    );
  }
}
