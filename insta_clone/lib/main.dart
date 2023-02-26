import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/responsive/responsive_layout_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'responsive/mobile_screen_layout.dart';
import 'responsive/web_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        backgroundColor: mobileBackgroundColor,
      ),
      home: const ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout()),
    );
  }
}
