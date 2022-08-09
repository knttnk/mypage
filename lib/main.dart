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

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mypage/settings.dart';

import "pages/home.dart";
import "about.dart";

void main() {
  AboutData.setupLicense();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState? of(BuildContext context) => context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    locale = const Locale("ja");
    super.initState();
  }

  Locale locale = const Locale("ja");

  void setLocale(Locale value) {
    setState(() {
      locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'),
        Locale('en'),
      ],
      locale: locale,
      title: "Website of knttnk",
      scrollBehavior: const CustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: Settings.fontFamily,
      ),
      home: const HomePage(),
    );
  }
}
