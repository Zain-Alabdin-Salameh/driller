import 'package:driller/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: const Color(0xff172E3E),
          primaryColorDark: const Color(0xFF172E3E),
          backgroundColor: const Color(0xFF1E1E1E)),
      home: const Home(),
    );
  }
}
