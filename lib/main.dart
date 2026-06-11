import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/works.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontFamily: 'vazir', color: Colors.black),
        ),
        cardTheme: const CardTheme(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        ),
      ),
      home: const MainWork(),
    );
  }
}