/// https://knttnk.github.io/mypage/#/
/// に公開しているページのソースコード
///
/// リポジトリは
/// https://github.com/knttnk/mypage/
///
/// 参考
/// https://zenn.dev/nekomimi_daimao/articles/26fd2e3b763191
/// https://qiita.com/qiuyin/items/a80ae53827ffb746a56f
///
/// 更新は，mainにコミットしてから
/// https://knttnk.github.io/mypage/?ecf0582
/// を見る．ecf0582をデプロイ番号？に変える

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'knttnkのサイト',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.mPlus1TextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("knttnkのウェブサイトだよ")),
      body: ListView(
        children: <Widget>[
          for (int i = 0; i < 100; i++) const Text('工事中だよ'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'test button',
        child: const Icon(Icons.add),
      ),
    );
  }
}
