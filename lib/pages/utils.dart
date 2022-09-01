import 'package:adaptive_scaffold/adaptive_scaffold.dart';

import 'utils.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mypage/about.dart';
import 'package:mypage/main.dart';
import 'package:mypage/settings.dart';

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
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      initialValue: "日本語",
      onSelected: (String v) => MyApp.of(context)?.setLocale(Locale(v)),
      tooltip: "Language",
      itemBuilder: (BuildContext context) {
        return [
          for (MapEntry e in languages.entries)
            PopupMenuItem(
              value: e.key,
              child: Text(e.value),
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
      title: SelectableText(content),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ContactTile(
            content: "なんとかなんとか",
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
    );
  }
}
