import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mypage/about.dart';
import 'package:mypage/main.dart';
import 'package:mypage/settings.dart';

class MySliverScaffold extends StatelessWidget {
  const MySliverScaffold({
    Key? key,
    required this.body,
    required this.drawer,
    required this.appBar,
  }) : super(key: key);
  final Widget body;
  final Widget drawer;
  final Widget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      body: CustomScrollView(
        slivers: <Widget>[
          appBar ?? const SizedBox(),
          body,
        ],
      ),
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
            leading: const Icon(Icons.quick_contacts_dialer),
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

class HomeTitleAppBar extends StatelessWidget {
  const HomeTitleAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: true,
      centerTitle: false,
      expandedHeight: (Theme.of(context).primaryTextTheme.titleLarge?.height ?? Settings.fallbackAppBarFontSize) * 5,
      title: Text(
        AppLocalizations.of(context)!.home_title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: const [LanguageSettings()],
      flexibleSpace: const Introduction(),
    );
  }
}

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double bodyFontSize = textTheme.bodyMedium?.fontSize ?? Settings.fallbackBodyFontSize;
    return FlexibleSpaceBar(
      background: Stack(
        fit: StackFit.passthrough,
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.black54),
            position: DecorationPosition.foreground,
            child: Image.asset(
              "assets/images/IMG_4919.HEIC",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: bodyFontSize / 2),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: const SizedBox(),
                title: Text(
                  AppLocalizations.of(context)!.introduction,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: bodyFontSize * 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
    const int childCount = 20;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          switch (index) {
            case childCount - 2:
              return contact;
            case childCount - 1:
              return SizedBox(
                height: MediaQuery.of(context).size.height / 2,
              );
            default:
              return ListTile(
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
              );
          }
        },
        childCount: childCount,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MySliverScaffold(
      drawer: HomeDrawer(),
      appBar: HomeTitleAppBar(),
      body: HomeContents(),
    );
  }
}
