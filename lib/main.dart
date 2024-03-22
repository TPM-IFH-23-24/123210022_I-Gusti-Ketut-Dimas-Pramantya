import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_app/pages/home.dart';
import 'package:travel_app/pages/login.dart';

void main() async {
  await GetStorage.init();
  runApp(const _TravelApp());
}

class _TravelApp extends StatelessWidget {
  const _TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage('');
    String username = storage.read('username') ?? "";
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        home: username == "" ? const Login() :  Home(username));
  }
}
