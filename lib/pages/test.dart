import 'dart:math';

import 'package:adaptive_scaffold/adaptive_scaffold.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'utils.dart';

import 'package:mypage/about.dart';
import 'package:mypage/main.dart';
import 'package:mypage/settings.dart';

class MySliverScaffold extends StatefulWidget {
  const MySliverScaffold({
    Key? key,
    required this.body,
    required this.appBar,
  }) : super(key: key);
  final Widget body;
  final Widget appBar;

  @override
  State<MySliverScaffold> createState() => _MySliverScaffoldState();
}

class _MySliverScaffoldState extends State<MySliverScaffold> {
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
    final Widget body = PrimaryScrollController(
      controller: scrollController!,
      child: CustomScrollView(
        restorationId: "scroll1",
        controller: scrollController,
        slivers: <Widget>[
          widget.appBar,
          widget.body,
        ],
      ),
    );
    return AdaptiveScaffold(
      destinations: [
        NavigationDestination(icon: const Icon(Icons.home), label: AppLocalizations.of(context)!.home),
        NavigationDestination(icon: const Icon(Icons.man), label: AppLocalizations.of(context)!.profile),
        NavigationDestination(icon: const Icon(Icons.article), label: AppLocalizations.of(context)!.publications),
        NavigationDestination(icon: const Icon(Icons.contact_mail), label: AppLocalizations.of(context)!.contact),
      ],
      body: (_) => body,
    );
  }
}

class HomeTitleAppBar extends StatelessWidget {
  const HomeTitleAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final double minHeight = (theme.primaryTextTheme.titleLarge?.height ?? Settings.fallbackAppBarFontSize) * 5;
    final double height = MediaQuery.of(context).size.height / 2;
    return SliverAppBar(
      pinned: true,
      primary: true,
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      expandedHeight: max(height, minHeight),
      title: Text(
        AppLocalizations.of(context)!.home_title,
        style: TextStyle(
          color: theme.colorScheme.onPrimary,
        ),
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
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final double bodyFontSize = textTheme.bodyMedium?.fontSize ?? Settings.fallbackBodyFontSize;
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
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
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontSize: bodyFontSize * 1.2,
                    fontWeight: FontWeight.normal,
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

class HomeContents extends StatelessWidget {
  const HomeContents({Key? key}) : super(key: key);
  final Widget contact = const ContactView();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final ColorScheme colorScheme = Theme.of(context).colorScheme;
          return Column(
            children: [
              ...List<Widget>.generate(
                20,
                (index) => Card(
                  child: ListTile(
                    title: Text(
                      '${AppLocalizations.of(context)!.content} $index',
                      style: TextStyle(color: colorScheme.onSecondaryContainer),
                    ),
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
              ),
              ListTile(
                title: Text(
                  "\n${AppLocalizations.of(context)!.contact}",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              contact,
              const SizedBox(
                height: kBottomNavigationBarHeight * 3,
              ),
            ],
          );
        },
        childCount: 1,
      ),
    );
  }
}

class AdaptiveHomePage extends StatelessWidget {
  const AdaptiveHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MySliverScaffold(
      appBar: HomeTitleAppBar(),
      body: HomeContents(),
    );
  }
}
