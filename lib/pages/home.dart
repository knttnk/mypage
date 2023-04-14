import 'dart:math';

import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'utils.dart';
import 'package:seo/seo.dart';

import 'package:mypage/theme.dart';

import 'package:mypage/about.dart';
import 'package:mypage/settings.dart';
// import "material3.dart";

class MySliverScaffold extends StatelessWidget {
  const MySliverScaffold({
    Key? key,
    required this.body,
    required this.appBar,
  }) : super(key: key);
  final Widget body;
  final Widget appBar;

  // Widget sizeAnimation(Widget child, Animation<double> animation) {
  //   final Animation<double> a = CurvedAnimation(
  //     parent: animation,
  //     curve: Curves.easeOutExpo,
  //     reverseCurve: Curves.easeInExpo,
  //   );
  //   return SizeTransition(
  //     sizeFactor: a,
  //     axis: Axis.horizontal,
  //     axisAlignment: -1,
  //     child: child,
  //   );
  // }

  // Widget reverseSizeAnimation(Widget child, Animation<double> animation) {
  //   return sizeAnimation(child, ReverseAnimation(animation));
  // }

  @override
  Widget build(BuildContext context) {
    final List<NavigationDestination> destinations = [
      NavigationDestination(
        icon: const Icon(Icons.home),
        label: AppLocalizations.of(context)!.home,
        tooltip: AppLocalizations.of(context)!.home,
      ),
      NavigationDestination(
        icon: const Icon(Icons.man),
        label: AppLocalizations.of(context)!.profile,
        tooltip: AppLocalizations.of(context)!.profile,
      ),
      NavigationDestination(
        icon: const Icon(Icons.article),
        label: AppLocalizations.of(context)!.publications,
        tooltip: AppLocalizations.of(context)!.publications,
      ),
      NavigationDestination(
        icon: const Icon(Icons.contact_mail),
        label: AppLocalizations.of(context)!.contact,
        tooltip: AppLocalizations.of(context)!.contact,
      ),
    ];
    final Widget body = CustomScrollView(
      slivers: <Widget>[
        appBar,
        this.body,
      ],
    );

    Widget myNavRail({required bool extended}) {
      final TextStyle labelTextTheme = MyTheme.themeData.textTheme.bodyLarge!;
      return SizedBox(
        width: extended ? 192 : 72,
        child: NavigationRail(
          selectedIndex: null,
          unselectedLabelTextStyle: labelTextTheme,
          selectedLabelTextStyle: labelTextTheme,
          extended: extended,
          destinations: destinations
              .map(
                (d) => NavigationRailDestination(
                  icon: d.icon,
                  label: Text(d.label),
                ),
              )
              .toList(),
        ),
      );
    }

    return AdaptiveLayout(
      bodyOrientation: Axis.vertical,
      // Primary navigation config has nothing from 0 to 600 dp screen width,
      // then an unextended NavigationRail with no labels and just icons then an
      // extended NavigationRail with both icons and labels.
      primaryNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.medium: SlotLayout.from(
            key: const Key('Primary Navigation Medium'),
            builder: (_) => myNavRail(extended: false),
          ),
          Breakpoints.large: SlotLayout.from(
            key: const Key('Primary Navigation Large'),
            builder: (_) => myNavRail(extended: true),
          ),
        },
      ),
      // Body switches between a ListView and a GridView from small to medium
      // breakpoints and onwards.
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.standard: SlotLayout.from(
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

class MyAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  final double maxExtent;

  @override
  final double minExtent;

  MyAppBarDelegate({
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
        title: SelectableText(AppLocalizations.of(context)!.my_name),
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
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image(
                        image: AssetImage(
                          "assets/images/IMG_4919.HEIC",
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          bottom: 10,
                        ),
                        child: SelectableRegion(
                          focusNode: FocusNode(),
                          selectionControls: DesktopTextSelectionControls(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SeoText(
                                AppLocalizations.of(context)!.introduction,
                                style: TextStyle(
                                  color: theme.colorScheme.onBackground,
                                  fontSize: bodyFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SeoText(
                                AppLocalizations.of(context)!.my_name,
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
                    ),
                    ...actions,
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
      delegate: MyAppBarDelegate(
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
              // Card(
              //   child: ListTile(
              //     title: Text(
              //       'material 3 test',
              //       style: TextStyle(color: colorScheme.onSecondaryContainer),
              //     ),
              //     onTap: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (context) => const Material3Test(),
              //         ),
              //       );
              //     },
              //   ),
              // ),
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
                  style: Theme.of(context).textTheme.headlineMedium,
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
