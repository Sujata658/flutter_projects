import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/components/components.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> handleSignUp(String name, String email, String phone,
      String password, String cpassword, BuildContext context) async {
    try {
      if (password == cpassword) {
        var newUser = {
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
          "cpassword": cpassword,
        };

        var response = await http.post(
          Uri.parse('http://localhost:5000/signup'),
          body: json.encode(newUser),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 422) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonDecode(response.body)['error'])),
          );
        } else if (response.statusCode == 201) {
          print(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonDecode(response.body)["message"])),
          );
          Navigator.pushNamed(context, '/login');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.body)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password and Confirm Password do not match')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(mainAxisAlignment: MainAxisAlignment.center,

                            children: [Icon(
                            Icons.person_add_outlined,
                            size: 50,
                          ),
                          ScreenTitle(title: ' Sign Up'),],

                          ),
                          
                          CustomTextField(
                            textField: TextField(
                              controller: _nameController,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Name',
                              ),
                            ),
                          ),
                          CustomTextField(
                            textField: TextField(
                              controller: _emailController,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Email',
                              ),
                            ),
                          ),
                          CustomTextField(
                            textField: TextField(
                              controller: _phoneController,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Phone',
                              ),
                            ),
                          ),
                          CustomTextField(
                            textField: TextField(
                              obscureText: true,
                              controller: _passwordController,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Password',
                              ),
                            ),
                          ),
                          CustomTextField(
                            textField: TextField(
                              controller: _confirmPasswordController,
                              decoration: const InputDecoration(
                                hintText: 'Confirm Password',
                              ),
                              obscureText: true,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          CustomButton(
                              buttonText: 'Sign Up',
                              onPressed: () {
                                final String name = _nameController.text;
                                final String email = _emailController.text;
                                final String phone = _phoneController.text;
                                final String password =
                                    _passwordController.text;
                                final String confirmPassword =
                                    _confirmPasswordController.text;

                                handleSignUp(name, email, phone, password,
                                    confirmPassword, context);
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Have an account?'),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  )),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Are you a driver?'),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/driversignup');
                                  },
                                  child: const Text(
                                    'Login As a Driver',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  )),
                                  
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
