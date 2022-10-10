import 'dart:ui' as ui;
import "package:flutter/material.dart";

abstract class Settings {
  static String get fontFamily => "MPlus1Gothic";

  static double fallbackAppBarFontSize = 30;
  static double fallbackBodyFontSize = 20;

  static List<Locale> supportedLocales = const [
    Locale('ja'),
    Locale('en'),
  ];
  static Locale get userLocale {
    final Locale locale = ui.window.locale;

    for (Locale l in Settings.supportedLocales) {
      if (locale.languageCode.startsWith(l.languageCode)) {
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
        return Scrollbar(
          thumbVisibility: true,
          controller: details.controller,
          child: child,
        );
    }
  }

  @override
  Set<ui.PointerDeviceKind> get dragDevices => {
        ui.PointerDeviceKind.touch,
        ui.PointerDeviceKind.mouse,
        ui.PointerDeviceKind.trackpad,
        ui.PointerDeviceKind.stylus,
        ui.PointerDeviceKind.invertedStylus,
        ui.PointerDeviceKind.unknown,
      };
}
