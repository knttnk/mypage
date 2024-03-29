/// https://knttnk.github.io/mypage/#/
/// に公開しているページのソースコード
///
/// リポジトリは
/// https://github.com/knttnk/mypage/
///
/// 参考
/// https://zenn.dev/nekomimi_daimao/articles/26fd2e3b763191
/// https://qiita.com/qiuyin/items/a80ae53827ffb746a56f
/// https://qiita.com/kazutxt/items/936ebe7a21ede7e1ab20  多言語
///
/// 更新は，mainにコミットしてから
/// https://knttnk.github.io/mypage/?bc50795
/// を見る． bc50795 をデプロイ番号？に変える
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mypage/settings.dart';import 'package:seo/seo.dart';


import "pages/home.dart";
// import "pages/test.dart" as test;
import "url_strategy/url_strategy.dart";
import "about.dart";
import 'theme.dart';

void main() {
  AboutData.setupLicense();
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState? of(BuildContext context) => context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  Locale? locale;

  @override
  void initState() {
    locale = Settings.userLocale;
    super.initState();
  }

  void setLocale(Locale value) {
    setState(() {
      locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {    
    return SeoController(
      tree: WidgetTree(context: context),
      enabled: kIsWeb,
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: Settings.supportedLocales,
        locale: locale,
        title: "Website of knttnk",
        scrollBehavior: const CustomScrollBehavior(),
        theme: MyTheme.themeData,
        home: const AdaptiveHomePage(),
        // home: const test.AdaptiveHomePage(),
      ),
    );
  }
}
