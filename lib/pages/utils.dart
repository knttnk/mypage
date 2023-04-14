import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mypage/main.dart';
import 'package:mypage/theme.dart';
import 'package:mypage/settings.dart';
import 'dart:ui' as ui;
import 'package:seo/seo.dart';

final Map<String, String> languages = {
  "ja": "日本語",
  "en": "English",
};

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        CupertinoIcons.globe,
        color: MyTheme.themeData.colorScheme.onBackground,
      ),
      initialValue: "日本語",
      onSelected: (String v) => MyApp.of(context)?.setLocale(Locale(v)),
      tooltip: "Language",
      itemBuilder: (BuildContext context) {
        return [
          for (MapEntry e in languages.entries)
            PopupMenuItem(
              value: e.key,
              child: Text(
                e.value,
                style: TextStyle(
                  color: MyTheme.themeData.colorScheme.onTertiaryContainer,
                ),
              ),
            ),
        ];
      },
    );
  }
}

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key? key,
    required this.content,
    required this.iconData,
  }) : super(key: key);

  final String content;
  final IconData iconData;
  void copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: content));
    final SnackBar bar = SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(
        AppLocalizations.of(context)!.copied,
        style: TextStyle(fontFamily: Settings.fontFamily),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(content),
      trailing: IconButton(
        onPressed: () => copyToClipboard(context),
        tooltip: "Copy",
        icon: const Icon(Icons.copy),
      ),
    );
  }
}

class ContactView extends StatelessWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SelectableRegion(
        selectionControls: desktopTextSelectionControls,
        focusNode: FocusNode(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ContactTile(
              content: "なんとかなんとか", // Osaka University, 2-1 Yamadaoka, Suita, Osaka 565-0871, Japan
              iconData: CupertinoIcons.map_pin_ellipse,
            ),
            ContactTile(
              content: "メールアドレス@ドメイン.com",
              iconData: CupertinoIcons.mail,
            ),
            ContactTile(
              content: "+81-00-0000-0000",
              iconData: CupertinoIcons.phone_fill,
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveBreakpointViewer extends StatelessWidget {
  const ActiveBreakpointViewer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  static const Map<Breakpoint, String> allBreakpoints = {
    Breakpoints.large: "large",
    Breakpoints.largeDesktop: "largeDesktop",
    Breakpoints.largeMobile: "largeMobile",
    Breakpoints.medium: "medium",
    Breakpoints.mediumAndUp: "mediumAndUp",
    Breakpoints.mediumDesktop: "mediumDesktop",
    Breakpoints.mediumMobile: "mediumMobile",
    Breakpoints.small: "small",
    Breakpoints.smallAndUp: "smallAndUp",
    Breakpoints.smallDesktop: "smallDesktop",
    Breakpoints.smallMobile: "smallMobile",
    Breakpoints.standard: "standard",
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        ColoredBox(
          color: Colors.white,
          child: Text(
            allBreakpoints.keys
                .where(
                  (b) => b.isActive(context),
                )
                .map(
                  (b) => allBreakpoints[b],
                )
                .join(", "),
          ),
        ),
      ],
    );
  }
}

class SeoText extends StatelessWidget {
  const SeoText(
    String this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : textSpan = null;

  final String data;
  final InlineSpan? textSpan;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) {
    return Seo.text(
      text: data,
      child: Text(
        data,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      ),
    );
  }
}
