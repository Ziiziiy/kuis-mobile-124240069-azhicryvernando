import 'package:flutter/material.dart';
import 'views/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toko Uniqlo',
      theme: ThemeData(colorSchemeSeed: Colors.redAccent, useMaterial3: true),
      home: const LoginPage(),
    );
  }
}
