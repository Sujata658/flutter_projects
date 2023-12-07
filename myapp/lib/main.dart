import 'package:flutter/material.dart';
import 'package:myapp/Pages/search.dart';
import 'package:myapp/Pages/sign_up.dart';
import 'package:myapp/Pages/login.dart';
import 'package:myapp/Pages/home.dart';
import 'package:myapp/Pages/map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: MapPage(),
      initialRoute: '/home',
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const Home(),
        '/map': (context) => const MapPage(),
        '/search': (context) => const SearchPage(),
      },
    );
  }
}
