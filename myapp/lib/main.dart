import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin.dart';
import 'package:myapp/Pages/home.dart';
import 'package:myapp/Pages/sign_up.dart';
import 'package:myapp/Pages/login.dart';
import 'package:myapp/Pages/searchpage.dart';
import 'package:myapp/Pages/map.dart';
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
      initialRoute: '/admin',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/signup': (context) => const SignUpPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const Home(),
        '/map': (context) => const MapPage(),
        '/search': (context) => const SearchPage(),
        '/admin': (context) => const AdminDash(),
      },
    );
  }
}
