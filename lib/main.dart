import 'package:flutter/material.dart';
import 'package:gdsport_flutter/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GDSport',
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'GDSport'),
      debugShowCheckedModeBanner: false,
    );
  }
}
