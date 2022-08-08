import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class Settings {
  static TextTheme textTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme ret = GoogleFonts.mPlus1TextTheme(theme.textTheme);
    _fontFamily = ret.bodyMedium?.fontFamily;
    return ret;
  }

  static String? _fontFamily;
  static String? get fontFamily => _fontFamily;
}
