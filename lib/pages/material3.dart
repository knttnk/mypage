import 'package:flutter/services.dart';
import "package:flutter/material.dart";

class Material3Test extends StatefulWidget {
  const Material3Test({Key? key}) : super(key: key);

  @override
  State<Material3Test> createState() => _Material3TestState();
}

class _Material3TestState extends State<Material3Test> {
  ///このwidgetの色
  ColorScheme get scheme => ColorScheme.fromSeed(
        seedColor: mainColor,
        brightness: useLightTheme ? Brightness.light : Brightness.dark,
      );
  static const List<Color> colors = [
    Color(0xfff62e36),
    Color(0xffccff33),
    Color(0xff007bbb),
    Color(0xff3eb370),
    Color(0xffff1493),
    Color(0xffff840a),
    Color(0xffffff66),
  ];
  Color mainColor = colors.first;
  bool useLightTheme = true;
  bool useCard = false;
  bool useM3 = true;

  void setTheme({Color? mainColor, bool? useLightTheme, bool? useCard, bool? useM3}) {
    setState(() {
      this.mainColor = mainColor ?? this.mainColor;
      this.useLightTheme = useLightTheme ?? this.useLightTheme;
      this.useCard = useCard ?? this.useCard;
      this.useM3 = useM3 ?? this.useM3;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget item(Color c, Color onC, String name, {String? onName}) {
      final String copyData1 = "$name: #${c.value.toRadixString(16)}";
      final String onNameNonNull = onName ?? "on${name[0].toUpperCase()}${name.substring(1)}";
      final String copyData2 = "$onNameNonNull: #${onC.value.toRadixString(16)}";
      final Widget ret = ListTile(
        tileColor: c,
        leading: IconButton(
          onPressed: () {
            Clipboard.setData(
              ClipboardData(text: "$copyData1, $copyData2"),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("コピーしました: $copyData1, $copyData2"),
              ),
            );
          },
          icon: Icon(
            Icons.file_copy,
            color: onC,
          ),
        ),
        title: SelectableText(
          copyData1,
          style: TextStyle(color: onC),
        ),
        subtitle: SelectableText(
          copyData2,
          style: TextStyle(color: onC),
        ),
      );

      if (useCard) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: ret,
        );
      } else {
        return ret;
      }
    }

    return MaterialApp(
      themeMode: useLightTheme ? ThemeMode.light : ThemeMode.dark,
      theme: ThemeData(useMaterial3: useM3, colorScheme: scheme),
      darkTheme: ThemeData(useMaterial3: useM3, colorScheme: scheme),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Material3のテストページ"),
        ),
        body: ListView(
          children: [
            ListTile(
              title: const Text("色"),
              trailing: DropdownButton<Color>(
                icon: Icon(
                  Icons.color_lens,
                  color: mainColor,
                ),
                value: mainColor,
                items: colors.map<DropdownMenuItem<Color>>(
                  (c) {
                    ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: c);
                    return DropdownMenuItem(
                      value: c,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: c,
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text(
                          "#${c.value.toRadixString(16)}",
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            backgroundColor: colorScheme.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    mainColor = value ?? colors.first;
                  });
                },
              ),
            ),
            SwitchListTile(
              value: useLightTheme,
              title: const Text("lightテーマにする"),
              onChanged: (toLight) {
                setTheme(useLightTheme: toLight);
              },
            ),
            SwitchListTile(
              value: useCard,
              onChanged: (value) {
                setTheme(useCard: value);
              },
              title: const Text("カードWidgetを使う"),
            ),
            SwitchListTile(
              value: useM3,
              title: const Text("色以外はMaterial3を使う"),
              onChanged: (value) {
                setTheme(useM3: value);
              },
            ),
            item(scheme.primary, scheme.onPrimary, "primary"),
            item(scheme.primaryContainer, scheme.onPrimaryContainer, "primaryContainer"),
            item(scheme.secondary, scheme.onSecondary, "secondary"),
            item(scheme.secondaryContainer, scheme.onSecondaryContainer, "secondaryContainer"),
            item(scheme.tertiary, scheme.onTertiary, "tertiary"),
            item(scheme.tertiaryContainer, scheme.onTertiaryContainer, "tertiaryContainer"),
            item(scheme.surface, scheme.onSurface, "surface"),
            item(scheme.inverseSurface, scheme.onInverseSurface, "inverseSurface"),
            item(scheme.inverseSurface, scheme.inversePrimary, "inverseSurface", onName: "inversePrimary"),
            item(scheme.surfaceVariant, scheme.onSurfaceVariant, "surfaceVariant"),
            item(scheme.background, scheme.onBackground, "background"),
            item(scheme.background, scheme.outline, "background", onName: "outline"),
            item(scheme.background, scheme.shadow, "background", onName: "shadow"),
            item(scheme.background, scheme.surfaceTint, "background", onName: "surfaceTint"),
            item(scheme.error, scheme.onError, "error"),
            item(scheme.errorContainer, scheme.onErrorContainer, "errorContainer"),
          ],
        ),
      ),
    );
  }
}
