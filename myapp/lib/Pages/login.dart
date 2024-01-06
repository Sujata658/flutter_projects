import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:myapp/Pages/components/components.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  Future<void> handlelogin(
      String email, String password, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      var user = {
        "email": email,
        "password": password,
      };
      var response = await http.post(
        Uri.parse('http://localhost:5000/login'),
        body: json.encode(user),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(response.body)['error'])),
        );
      } else if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsonDecode(response.body)['message']),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const TopScreenImage(screenImageName: 'login.png'),
            Expanded(
              flex: 2,
              child:
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ScreenTitle(title: 'Login'),
                  CustomTextField(
                    textField: TextField(
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(hintText: 'Email'),
                      controller: emailController,
                    ),
                  ),
                  CustomTextField(
                    textField: TextField(
                      obscureText: true,
                      controller: passwordController,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                  ),
                  CustomButton(
                    buttonText: 'Login',
                    onPressed: () {
                      final String email = emailController.text;
                      final String password = passwordController.text;
                      // print(email);
                      // print(password);
                      handlelogin(email, password, context);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Forgot Password?'),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: const Text(
                            'Sign Up',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}







