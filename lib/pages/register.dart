import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:travel_app/pages/login.dart';

const primaryBlue = Color.fromARGB(255, 2, 112, 158);
const primaryGray = Color.fromARGB(255, 217, 217, 217);

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _register() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String username = _usernameController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (email == "" || password == "" || username == "" || password == "") {
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
          content: const Text(
            "All field must be filled!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
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
                    backgroundColor: Colors.red, foregroundColor: Colors.white),
                child: const Text('DISMISS'),
              ),
            ),
          ],
        ),
      );
    }

    if (password != confirmPassword) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(
            Icons.warning,
            color: Colors.red,
            size: 80,
          ),
          title: const Text(
            'Register Failed',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          content: const Text(
            "Password and confirm password doesn't match!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
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
                    backgroundColor: Colors.red, foregroundColor: Colors.white),
                child: const Text('DISMISS'),
              ),
            ),
          ],
        ),
      );
    }

    final response = await http.post(
      Uri.parse('https://backend-p3runt4vfa-et.a.run.app/users/register'),
      body: {'email': email, 'password': password, 'username': username},
    );
    print(response.headers);
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (response.statusCode == 201) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
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
            'Register Failed',
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
                    backgroundColor: Colors.red, foregroundColor: Colors.white),
                child: const Text('DISMISS'),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: Center(
      child: SizedBox(
        width: 400,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            UnconstrainedBox(
              child: Image.asset(
                "assets/images/bike.png",
                width: 300,
                height: 114,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            const Text(
              "Hello!",
              style: TextStyle(
                  color: primaryBlue,
                  fontSize: 36,
                  fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
            const Text(
              "Let's Start Your Journey",
              style: TextStyle(
                  color: primaryBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
            Form(
              child: Column(
                children: [
                  UnconstrainedBox(
                    child: SizedBox(
                      width: 312,
                      height: 49,
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          label: const Text("Username"),
                          suffixIcon: const Icon(Icons.person_pin_rounded),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: primaryGray, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: primaryBlue, width: 2.0),
                          ),
                          contentPadding: const EdgeInsets.only(bottom: 2, left: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  UnconstrainedBox(
                    child: SizedBox(
                      width: 312,
                      height: 49,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          label: const Text("Email"),
                          suffixIcon: const Icon(Icons.email),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: primaryGray, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: primaryBlue, width: 2.0),
                          ),
                          contentPadding:
                              const EdgeInsets.only(bottom: 2, left: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  UnconstrainedBox(
                    child: SizedBox(
                      width: 312,
                      height: 49,
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          label: const Text("Password"),
                          suffixIcon: const Icon(Icons.lock),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: primaryGray, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: primaryBlue, width: 2.0),
                          ),
                          contentPadding:
                              const EdgeInsets.only(bottom: 2, left: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  UnconstrainedBox(
                    child: SizedBox(
                      width: 312,
                      height: 49,
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          label: const Text("Confirm Password"),
                          suffixIcon: const Icon(Icons.lock),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: primaryGray, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: primaryBlue, width: 2.0),
                          ),
                          contentPadding:
                              const EdgeInsets.only(bottom: 2, left: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  UnconstrainedBox(
                    child: SizedBox(
                      width: 314,
                      height: 45,
                      child: ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[700],
                          ),
                          child: const Text("Register")),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsetsDirectional.only(end: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 0.5),
                    child: const Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                          fontSize: 12,
                          color: primaryBlue,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    )));
  }
}
