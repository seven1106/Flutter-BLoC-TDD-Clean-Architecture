import 'package:flutter/material.dart';
import 'package:flutter_supabase_forums/core/theme/app_palette.dart';

class AppTheme {
  static final lightTheme = ThemeData.light();
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
  );
}