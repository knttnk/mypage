import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mypage/settings.dart';
import 'package:flutter/services.dart';
import 'package:mypage/about.dart';

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
        children: const [
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
          ),
          ListTile(
            title: Text("Profile"),
            leading: Icon(Icons.man),
          ),
          ListTile(
            title: Text("Publications"),
            leading: Icon(Icons.article),
          ),
          ListTile(
            title: Text("Contact"),
            leading: Icon(Icons.quick_contacts_dialer),
          ),
          About(),
        ],
      ),
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
      expandedHeight: (Theme.of(context).primaryTextTheme.titleLarge?.height ?? 30) * 5,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Text(AppLocalizations.of(context)!.home_title),
        background: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.black45),
          position: DecorationPosition.foreground,
          child: Image.asset(
            "assets/images/IMG_4919.HEIC",
            fit: BoxFit.cover,
          ),
        ),
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
        "コピーしました",
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
            "\n連絡先",
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
          content: "+81 00 0000 0000",
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
                title: Text('コンテンツ$index'),
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
