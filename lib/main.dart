import 'package:flutter/material.dart';
import 'package:photo_editor/screens/home_screens.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Editor',
      theme: ThemeData.light(),
      home: HomeScreen(),
    );
  }
}
