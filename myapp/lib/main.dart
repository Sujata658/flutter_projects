import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin.dart';
import 'package:myapp/Pages/homepages/home.dart';
import 'package:myapp/Pages/authpages/sign_up.dart';
import 'package:myapp/Pages/authpages/login.dart';
import 'package:myapp/Pages/homepages/searchpage.dart';
import 'package:myapp/Pages/homepages/map.dart';
import 'package:myapp/Pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // home: MapPage(),
      initialRoute: '/home',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/signup': (context) => const SignUpPage(),
        '/login': (context) => const LoginPage(),

        //homescreen
        '/home': (context) => const Home(),
        '/map': (context) => const MapPage(),
        '/search': (context) => const SearchPage(),

        //admin components
        '/admin': (context) => AdminDashboard(),

        //support pages
      },
    );
  }
}
