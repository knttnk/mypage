import 'package:flutter/material.dart';
import 'package:mypage/settings.dart';

abstract class MyTheme {
  static const Color colorSchemeSeed = Color.fromARGB(255, 2, 94, 63);
  static final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: colorSchemeSeed);

  static final ThemeData themeData = ThemeData(
    colorSchemeSeed: colorSchemeSeed,
    fontFamily: Settings.fontFamily,
    brightness: Brightness.light,
    cardTheme: CardTheme(
      elevation: 0,
      color: colorScheme.secondaryContainer,
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: colorScheme.background,
      selectedIconTheme: IconThemeData(color: colorScheme.secondary),
      unselectedIconTheme: IconThemeData(color: colorScheme.secondary),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colorScheme.background,
      selectedItemColor: colorScheme.secondary,
      unselectedItemColor: colorScheme.secondary,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: colorScheme.tertiaryContainer,
    ),
    useMaterial3: true,
  );
}
