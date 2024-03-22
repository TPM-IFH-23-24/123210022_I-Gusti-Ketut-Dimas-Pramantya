import "package:flutter/material.dart";
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:travel_app/pages/home.dart';
import 'package:travel_app/pages/register.dart';

const primaryBlue = Color.fromARGB(255, 2, 112, 158);
const primaryGray = Color.fromARGB(255, 217, 217, 217);

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('https://backend-p3runt4vfa-et.a.run.app/users/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      final String username = responseBody['username'];
      await GetStorage().write('username', username);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(username),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(
            Icons.warning,
            color: Colors.red,
            size: 80,
          ),
          title: const Text(
            'Login Failed',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          content: Text(
            responseBody['message'],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          ),
          actions: [
            SizedBox(
              // Wrap the button with SizedBox
              width: double.infinity, // Set width to infinity
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white
                ),
                child: const Text('DISMISS'),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: (Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/plane.png",
                width: 300,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Hello",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: primaryBlue,
                    fontSize: 36,
                    fontWeight: FontWeight.w900),
              ),
              const Text(
                "Sign in to Your Account",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: primaryBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                child: Column(
                  children: [
                    SizedBox(
                      width: 312,
                      height: 49,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.email),
                            label: const Text("Email"),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: primaryGray, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: primaryBlue, width: 3.0),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 312,
                      height: 49,
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.lock),
                          label: const Text("Password"),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: primaryGray, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: primaryBlue, width: 3.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 314,
                      height: 45,
                      child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Login")),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 217, 217, 217),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text('OR'),
                  SizedBox(width: 20),
                  Flexible(
                    child: Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 217, 217, 217),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 312,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Implement your sign-in logic here (e.g., call _signIn function)
                  },
                  icon: Image.asset(
                    'assets/images/google.png',
                    height: 24,
                  ),
                  label: const Text('Sign in with Google'),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                    padding: const EdgeInsets.all(8),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.only(right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(end: 1.5),
                      child: const Text(
                        "Doesn't have an account? ",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
