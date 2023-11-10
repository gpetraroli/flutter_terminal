import 'package:flutter/material.dart';

var defaultTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    background: Colors.grey.shade100,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.all(Colors.white),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      iconSize: MaterialStateProperty.all(14),
    ),
  ),
  useMaterial3: true,
);
