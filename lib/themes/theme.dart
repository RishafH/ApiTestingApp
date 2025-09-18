import 'package:flutter/material.dart';
final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.grey[50],

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      backgroundColor: const Color.fromARGB(255, 2, 159, 231),
    ),
  ),
  // card theme for neat cards
  cardTheme: CardTheme(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  // app bar theme
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 3,
    color: Colors.blueGrey  ,
    titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  ),
  // text theme
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(fontSize: 12),
  ),
);
