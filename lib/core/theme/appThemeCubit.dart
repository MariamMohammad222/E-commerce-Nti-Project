import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeCubit extends Cubit<ThemeMode> {
  static const String _key = 'theme';

  AppThemeCubit() : super(ThemeMode.system) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString(_key);

    if (theme == 'light') {
      emit(ThemeMode.light);
    } else if (theme == 'dark') {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.system);
    }
  }

  Future<void> changeAppTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    if (mode == ThemeMode.light) {
      prefs.setString(_key, 'light');
    } else if (mode == ThemeMode.dark) {
      prefs.setString(_key, 'dark');
    } else {
      prefs.setString(_key, 'system');
    }

    emit(mode);
  }
}