import 'dart:math';

import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'utils.dart';
import 'package:mypage/theme.dart';

import 'package:mypage/about.dart';
import 'package:mypage/settings.dart';

class MySliverScaffold extends StatelessWidget {
  const MySliverScaffold({
    Key? key,
    required this.body,
    required this.appBar,
  }) : super(key: key);
  final Widget body;
  final Widget appBar;

  @override
  Widget build(BuildContext context) {
    final List<NavigationDestination> destinations = [
      NavigationDestination(icon: const Icon(Icons.home), label: AppLocalizations.of(context)!.home),
      NavigationDestination(icon: const Icon(Icons.man), label: AppLocalizations.of(context)!.profile),
      NavigationDestination(icon: const Icon(Icons.article), label: AppLocalizations.of(context)!.publications),
      NavigationDestination(icon: const Icon(Icons.contact_mail), label: AppLocalizations.of(context)!.contact),
    ];
    final List<NavigationRailDestination> railDestinations = destinations
        .map(
          (d) => AdaptiveScaffold.toRailDestination(d),
        )
        .toList();
    final Widget body = CustomScrollView(
      slivers: <Widget>[
        appBar,
        this.body,
      ],
    );
    return AdaptiveLayout(
      // Primary navigation config has nothing from 0 to 600 dp screen width,
      // then an unextended NavigationRail with no labels and just icons then an
      // extended NavigationRail with both icons and labels.
      primaryNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.medium: SlotLayout.from(
            inAnimation: AdaptiveScaffold.leftOutIn,
            key: const Key('Primary Navigation Medium'),
            builder: (_) => SizedBox(
              width: 72,
              child: NavigationRail(
                destinations: railDestinations,
                selectedIndex: null,
              ),
            ),
          ),
          Breakpoints.large: SlotLayout.from(
            inAnimation: AdaptiveScaffold.leftOutIn,
            key: const Key('Primary Navigation Medium'),
            builder: (_) => SizedBox(
              width: 192,
              child: NavigationRail(
                destinations: railDestinations,
                selectedIndex: null,
                extended: true,
              ),
            ),
          ),
        },
      ),
      // Body switches between a ListView and a GridView from small to medium
      // breakpoints and onwards.
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          // for b in Breakpoints.
          Breakpoints.small: SlotLayout.from(
            key: const Key('Body Small'),
            builder: (context) => body,
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('Body Medium'),
            builder: (context) => body,
          )
        },
      ),
      // BottomNavigation is only active in small views defined as under 600 dp
      // width.
      bottomNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('Bottom Navigation Small'),
            builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
              destinations: destinations,
            ),
          )
        },
      ),
    );
  }
}

class MyAppbarDelegate extends SliverPersistentHeaderDelegate {
  @override
  final double maxExtent;

  @override
  final double minExtent;

  MyAppbarDelegate({
    required this.maxExtent,
    this.minExtent = kToolbarHeight,
  });
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    const actions = [
      LanguageSettings(),
      About(),
    ];
    final double animation = min(shrinkOffset / (maxExtent - minExtent), 1);
    final ThemeData theme = MyTheme.themeData;
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    final double bodyFontSize = textTheme.bodyMedium?.fontSize ?? Settings.fallbackBodyFontSize;

    return FlexibleSpaceBar.createSettings(
      minExtent: minExtent,
      maxExtent: maxExtent,
      currentExtent: max(minExtent, maxExtent - shrinkOffset),
      toolbarOpacity: animation,
      isScrolledUnder: true,
      child: AppBar(
        surfaceTintColor: colorScheme.surfaceTint,
        title: Text(AppLocalizations.of(context)!.my_name),
        toolbarOpacity: animation,
        actions: actions,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: ColoredBox(
            color: colorScheme.background,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Image(
                      fit: BoxFit.fill,
                      isAntiAlias: true,
                      image: AssetImage(
                        "assets/images/IMG_4919.HEIC",
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        bottom: 10,
                      ),
                      child: SelectableText.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: "${AppLocalizations.of(context)!.introduction}\n",
                              style: TextStyle(
                                color: theme.colorScheme.onBackground,
                                fontSize: bodyFontSize,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)!.my_name,
                              style: TextStyle(
                                color: theme.colorScheme.onBackground,
                                fontSize: bodyFontSize * 2,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actions,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

class HomeTitleAppBar extends StatelessWidget {
  const HomeTitleAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double minHeight = (theme.primaryTextTheme.titleLarge?.height ?? Settings.fallbackAppBarFontSize) * 5;
    final double height = MediaQuery.of(context).size.height * 0.8;
    return SliverPersistentHeader(
      pinned: true,
      delegate: MyAppbarDelegate(
        maxExtent: max(height, minHeight),
      ),
    );
  }
}

class HomeContents extends StatelessWidget {
  const HomeContents({Key? key}) : super(key: key);
  final Widget contact = const ContactView();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = MyTheme.colorScheme;
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Column(
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
          ),
        ],
      ),
    );
  }
}

class AdaptiveHomePage extends StatelessWidget {
  const AdaptiveHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MySliverScaffold(
        appBar: HomeTitleAppBar(),
        body: HomeContents(),
      ),
    );
  }
}

void func() {
  SliverAnimatedList;
  SliverAnimatedOpacity;
  SliverAppBar;
  SliverFadeTransition;
  SliverFillRemaining;
  SliverFillViewport;
  SliverFixedExtentList;
  SliverGrid;
  SliverIgnorePointer;
  SliverLayoutBuilder;
  SliverList;
  SliverMultiBoxAdaptorWidget;
  SliverOffstage;
  SliverOpacity;
  SliverOverlapAbsorber;
  SliverOverlapInjector;
  SliverPadding;
  SliverPersistentHeader;
  SliverPrototypeExtentList;
  SliverReorderableList;
  SliverSafeArea;
  SliverToBoxAdapter;
  SliverVisibility;
  SliverWithKeepAliveWidget;
  SliverConstraints;
}
