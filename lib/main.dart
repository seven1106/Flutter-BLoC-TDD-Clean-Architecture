import 'package:flutter/material.dart';
import 'package:flutter_supabase_forums/core/theme/theme.dart';

import 'features/auth/presentation/pages/sign_up_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FSCA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SignUpPage(),
    );
  }
}
