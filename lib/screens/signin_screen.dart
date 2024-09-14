// import 'package:flut_demo/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/screens/signup_screen.dart';
import '../reusable_widget/reusable_widget.dart';
import '../utils/color_utils.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}): super(key:key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
                  hexStringToColor("CB2B93"),
                  hexStringToColor("9546C4"),
                  hexStringToColor("5E61F4"),
                ],begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo2.png"),
                const SizedBox(height: 30,),
                reusableTextField(
                    "Enter Username",
                    Icons.person_outline,
                    false,
                    _emailTextController),
                const SizedBox(height: 30,),
                reusableTextField(
                    "Enter Password",
                    Icons.lock_outline,
                    false,
                    _passwordTextController),
                const SizedBox(height: 30,),
                signInsignUpButton(context, true, (){}),
                signUpOption(),
              ],
            ),
          ),
        ),
    ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(color: Colors.white70)), // Text
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupScreen()),
            );
          },
          child: const Text(
            " SignUp",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }


}
