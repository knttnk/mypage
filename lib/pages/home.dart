import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        children: const [
          ListTile(
            title: SelectableText("Home"),
            leading: Icon(Icons.home),
          ),
          ListTile(
            title: SelectableText("Profile"),
            leading: Icon(Icons.man),
          ),
          ListTile(
            title: SelectableText("Publications"),
            leading: Icon(Icons.article),
          ),
          ListTile(
            title: SelectableText("Contact"),
            leading: Icon(Icons.quick_contacts_dialer),
          ),
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
        title: SelectableText(
          AppLocalizations.of(context)!.home_title,
          style: Settings.textTheme(context).headline6?.copyWith(color: Colors.white),
        ),
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

class HomeContents extends StatelessWidget {
  const HomeContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ListTile(
            title: SelectableText('コンテンツ$index'),
            onTap: () {
              final SnackBar bar = SnackBar(
                content: SelectableText(
                  'コンテンツ$indexをクリックしていただきましたが，特に何も実装していません．',
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(bar);
            },
          );
        },
        childCount: 60,
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
