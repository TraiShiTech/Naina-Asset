import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:url_strategy/url_strategy.dart';

import 'app/home.dart';

///----------------------------------------------------->
/// flutter run --enable-software-rendering
/// flutter run -d chrome --web-renderer html --enable-software-rendering
/// flutter run -d chrome  --no-sound-null-safety
/// flutter run -d chrome --web-browser-flag "--disable-web-security" (แก้ปัญหา security  CORS (Cross-Origin Resource Sharing))
/// flutter run -d web-server
///----------------------------------------------------->4
/// flutter build web --web-renderer html --release
///  flutter build web --release --no-sound-null-safety
/// flutter build web --web-renderer html --release --no-sound-null-safety
///  flutter build web --web-renderer html --release --dart-define=web-browser-flag=--disable-web-security (แก้ปัญหา security  CORS (Cross-Origin Resource Sharing))
///  flutter build web --web-renderer html --release --no-sound-null-safety --dart-define=web-browser-flag=--disable-web-security (แก้ปัญหา security  CORS (Cross-Origin Resource Sharing))
///  flutter build web --release --web-renderer=html --dart-define=web-browser-flag=--disable-web-security
//----------------------------------------------------->
// flutter build web --web-renderer html --release --dart-define=web-browser-flag=--disable-web-security --no-tree-shake-icons (แก้ปัญหา This application cannot tree shake icons fonts. It has non-constant instances of IconData at the following location)
///
///flutter build web --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false   (แก้ปัญหา Security Capture Screen )
///flutter build web --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false-browser-flag=--disable-web-security  (แก้ปัญหา Security Capture Screen + security  CORS )
///flutter build web --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false-define=web-browser-flag=--disable-web-security --no-tree-shake-icons  (แก้ปัญหา Security Capture Screen + security  CORS + icons )
///
//*/flutter build web --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false-browser-flag=--disable-web-security --no-tree-shake-icons
//----(Git Lab)
//1.----> git add .
//2.------> git remote set-url origin https://github.com/TraiShiTech/Naina-Asset.git
//3.-------->git commit -m "Start 2"
//4.-----------> git push origin main
//----------------------------------------------------->
//----(Git Hub)
//1.----> git add .
//2.------> git remote set-url origin https://github.com/TraiShiTech/Naina-Asset.git
//3.-------->git commit -m "commit message"
//4.-----------> git push origin main
//----------------------------------------------------->Test_disabled01  11-04 m5
void main() {
  // setPathUrlStrategy();
  runApp(const ProviderScope(child: Ventura()));
}

class Ventura extends StatelessWidget {
  const Ventura({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naina Asset',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      scrollBehavior: MyCustomScrollBehavior(),
      home: const Home(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
