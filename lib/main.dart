import 'package:flutter/material.dart';
import 'package:westminster/pages/start_page.dart';

void main() {
  runApp(const Westminster());
}

class Westminster extends StatelessWidget {
  const Westminster({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Westminster',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartPage(),
    );
  }
}
