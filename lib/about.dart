import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_browser_detect/web_browser_detect.dart';

abstract class AboutData {
  static void setupLicense() {
    LicenseRegistry.addLicense(
      () => Stream.fromFutures([
        AboutData.aboutMPlus1Gothic.then(
          (str) => LicenseEntryWithLineBreaks(<String>['M+ FONTS'], str),
        ),
      ]),
    );
  }

  static String? _aboutMPlus1Gothic;
  static Future<String> get aboutMPlus1Gothic async {
    AboutData._aboutMPlus1Gothic ??= await rootBundle.loadString('assets/about/MPlus1Gothic.txt');
    return AboutData._aboutMPlus1Gothic!;
  }
}

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String s = "not browser";
    if (kIsWeb) {
      final browser = Browser();
      s = '${browser.browser} ${browser.version}';
    }

    print(s);

    return ListTile(
      title: const Text("About this page"),
      subtitle: Text(s),
      onTap: () => showAboutDialog(context: context, children: []),
    );
  }
}
