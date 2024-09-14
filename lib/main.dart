

// ***************** project news app *************************** //

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flut_demo/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/screens/signin_screen.dart';
import './screens/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
      home: const SigninScreen(),
    );
  }
}



