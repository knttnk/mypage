import 'dart:ui';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

abstract class Settings {
  static String get fontFamily => "MPlus1Gothic";

  static double fallbackAppBarFontSize = 30;
  static double fallbackBodyFontSize = 20;

  static List<Locale> supportedLocales = const [
    Locale('ja'),
    Locale('en'),
  ];
  static Locale locale({required String localeName}) {
    for (Locale l in Settings.supportedLocales) {
      if (localeName.startsWith(l.languageCode)) {
        return l;
      }
    }
    return Settings.supportedLocales.first;
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  const CustomScrollBehavior();

  /// https://github.com/mono0926/flutter_playground/blob/891b20b8c13d7addcaf510a9ad993366c9efc832/lib/main_platform.dart#L255-L273
  /// スクロールバーの描画
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (axisDirectionToAxis(details.direction)) {
      case Axis.horizontal:
        return child;
      case Axis.vertical:
        return CupertinoScrollbar(
          thumbVisibility: true,
          controller: details.controller,
          child: child,
        );
    }
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        // PointerDeviceKind.mouse,
      };
}
