import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData get lightTheme => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarThemeData(
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
      titleSmall: TextStyle(color: Colors.black),
      labelLarge: TextStyle(color: Colors.black),
    ),
    cardTheme: CardThemeData(color: Colors.white),

    inputDecorationTheme: InputDecorationThemeData(
      labelStyle: TextStyle(color: const Color.fromARGB(255, 29, 13, 13)),
      hintStyle: TextStyle(color: Colors.black),
      prefixIconColor: Colors.black,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    iconTheme: IconThemeData(color: Colors.black),
  );

  static ThemeData get darkTheme => ThemeData(
    scaffoldBackgroundColor: Colors.black,

    appBarTheme: AppBarThemeData(
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      backgroundColor: Colors.black,
      centerTitle: true,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: Colors.white),
    ),

    inputDecorationTheme: InputDecorationThemeData(
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white),
      prefixIconColor: Colors.white,
      errorStyle: TextStyle(color: Colors.red, fontSize: 14),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.black87),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
