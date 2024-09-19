import 'package:flutter/material.dart';
// import 'package:news_app/screens/signin_screen.dart';
import 'package:newsapp/screens/signin_screen.dart';
// import './screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SigninScreen(),
    );
  }
}