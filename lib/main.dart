import 'package:flutter/material.dart';

import 'ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: const Color(0xfff5f5f5),
        ),
        fontFamily: 'Roboto Mono',
      ),
      home: const HomePage(),
    );
  }
}
