import 'package:flutter/material.dart';

const double smallDistance = 8.0;
const double mediumDistance = 16.0;
const double largeDistance = 24.0;
const double xLargeDistance = 32.0;

const double smallRadius = 8.0;
const double mediumRadius = 16.0;
const double largeRadius = 24.0;
const double xLargeRadius = 32.0;

const double iconSize = 24.0;

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
const blackColor = Color(0xff1F1449);
const greyColor = Color(0xff9698A9);
const actionColor = Color(0xFF5F5FA7);

BottomNavigationBarThemeData bottomNavigationBarTheme =
    const BottomNavigationBarThemeData(
  selectedItemColor: primaryColor,
  unselectedItemColor: greyColor,
  showSelectedLabels: false,
  showUnselectedLabels: false,
  backgroundColor: primaryColor,
  type: BottomNavigationBarType.fixed,
);

const light = FontWeight.w300;
const regular = FontWeight.w400;
const medium = FontWeight.w500;
const semiBold = FontWeight.w600;
const bold = FontWeight.w700;
const extraBold = FontWeight.w800;
const black = FontWeight.w900;

const textTheme = TextTheme(
  headlineSmall: TextStyle(
    color: white,
    fontSize: 46,
    fontWeight: bold,
  ),
  headlineLarge: TextStyle(
    color: white,
    fontWeight: bold,
  ),
  headlineMedium: TextStyle(
    color: white,
    fontWeight: bold,
  ),
  bodySmall: TextStyle(
    color: white,
    fontSize: 14,
    fontWeight: medium,
  ),
  bodyMedium: TextStyle(
    color: white,
    fontSize: 14,
    fontWeight: medium,
  ),
  bodyLarge: TextStyle(
    color: white,
    fontSize: 24,
    fontWeight: medium,
  ),
  titleMedium: TextStyle(
    color: white,
  ),
);

const iconTheme = IconThemeData(color: white);

const colorScheme = ColorScheme(
  primary: primaryColor,
  primaryContainer: blackColor,
  secondary: primaryColor,
  secondaryContainer: primaryColor,
  surface: blackColor,
  background: scaffoldBackgroundColor,
  error: Colors.red,
  onPrimary: blackColor,
  onSecondary: blackColor,
  onSurface: Colors.white,
  onBackground: scaffoldBackgroundColor,
  onError: Colors.red,
  brightness: Brightness.dark,
);
