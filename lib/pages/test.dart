import 'dart:math';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mypage/about.dart';
import 'package:mypage/main.dart';
import 'package:mypage/settings.dart';

class TestScaffold extends StatefulWidget {
  const TestScaffold({
    Key? key,
    required this.body,
    required this.drawer,
    required this.appBar,
  }) : super(key: key);
  final Widget body;
  final Widget drawer;
  final PreferredSizeWidget? appBar;

  @override
  State<TestScaffold> createState() => _TestScaffoldState();
}

class _TestScaffoldState extends State<TestScaffold> {
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final Widget drawer = widget.drawer;
    return OrientationBuilder(
      builder: (context, orientation) {
        final bool isLandscape = orientation == Orientation.landscape;
        return Scaffold(
          drawer: isLandscape ? null : drawer,
          appBar: widget.appBar,
          body: isLandscape
              ? Row(
                  children: [
                    drawer,
                    Expanded(child: widget.body),
                  ],
                )
              : widget.body,
        );
      },
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.home),
            leading: const Icon(Icons.home),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.profile),
            leading: const Icon(Icons.man),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.publications),
            leading: const Icon(Icons.article),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.contact),
            leading: const Icon(Icons.contact_mail),
          ),
          const About(),
        ],
      ),
    );
  }
}

final Map<String, String> languages = {
  "ja": "日本語",
  "en": "English",
};

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(CupertinoIcons.globe),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            "\n${AppLocalizations.of(context)!.contact}",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const ContactTile(
          content: "なんとかなんとか",
          iconData: CupertinoIcons.map_pin_ellipse,
        ),
        const ContactTile(
          content: "メールアドレス@ドメイン.com",
          iconData: CupertinoIcons.mail,
        ),
        const ContactTile(
          content: "+81-00-0000-0000",
          iconData: CupertinoIcons.phone_fill,
        ),
      ],
    );
  }
}

class HomeContents extends StatelessWidget {
  const HomeContents({Key? key}) : super(key: key);
  final Widget contact = const ContactView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List<Widget>.generate(
            20,
            (index) => ListTile(
              title: Text('${AppLocalizations.of(context)!.content} $index'),
              onTap: () {
                final SnackBar bar = SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Text(
                    'コンテンツ$indexをクリックしていただきましたが，特に何も実装していません．',
                    style: TextStyle(fontFamily: Settings.fontFamily),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(bar);
              },
            ),
          ),
          contact,
          const SizedBox(
            height: kBottomNavigationBarHeight * 3,
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TestScaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        primary: true,
        title: Text(
          AppLocalizations.of(context)!.home_title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [LanguageSettings()],
      ),
      body: HomeContents(),
    );
  }
}
