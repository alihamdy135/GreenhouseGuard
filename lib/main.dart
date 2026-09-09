// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_controller.dart';
import 'charscreen.dart';
import 'home.dart';
import 'saftey.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //   home: const Auth(),
      routes: {
        '/': (context) => const Auth(),
        'chartscreen': (context) => ChartScreen(),
        'home': (context) => ChatbotScreen(),
        'Safe': (context) => DataIndexScreen()
      },
    );
  }
}
