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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      title: "Website of knttnk",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        textTheme: GoogleFonts.mPlus1TextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: true,
            expandedHeight: Theme.of(context).primaryTextTheme.titleLarge?.height ?? 30 * 5,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(AppLocalizations.of(context)!.home_title),
              background: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.hardLight,
                ),
                child: Image.asset(
                  "assets/images/IMG_4919.HEIC",
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
          ),
          const SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            automaticallyImplyLeading: false,
            title: Text('工事中です．以下はテスト中'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('コンテンツ$index'),
                  onTap: () {
                    final SnackBar bar = SnackBar(
                      content: Text(
                        'コンテンツ$indexをクリックしていただきましたが，特に何も実装していません．',
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(bar);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
