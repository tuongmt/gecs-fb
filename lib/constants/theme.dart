import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.blue,
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    foregroundColor: Colors.blue,
    textStyle: const TextStyle(color: Colors.blue),
    side: const BorderSide(color: Colors.blue, width: 1.5),
  )),
  inputDecorationTheme: InputDecorationTheme(
    border: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    errorBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        disabledBackgroundColor: Colors.grey),
  ),
  primarySwatch: Colors.blue,
  primaryColorDark: Colors.blue,
  canvasColor: Colors.blue,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
      toolbarTextStyle: TextStyle(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black)),
);

OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(
  color: Colors.grey,
));
