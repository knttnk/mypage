import 'dart:ui';
import "package:flutter/material.dart";

abstract class Settings {
  static String get fontFamily => "MPlus1Gothic";

  static double fallbackAppBarFontSize = 30;
  static double fallbackBodyFontSize = 20;
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

  /// https://note.com/hatchoutschool/n/nfe12a0aa069a
  /// モバイルでもドラッグできるように
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
