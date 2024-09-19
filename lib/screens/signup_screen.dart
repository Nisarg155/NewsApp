import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http; // For HTTP requests
// import 'package:news_app/screens/home_screen.dart'; // Import HomeScreen
import '../reusable_widget/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  // Function to sign up the user
  Future<void> signUpUser(
      String username, String email, String password) async {
    var url =
        Uri.parse('http://10.0.2.2:5000/api/auth/signup'); // Adjust as needed
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Print the raw response body

    if (response.statusCode == 201) {
      try {
        // Check for any unwanted characters or invalid JSON format
        String responseBody =
            response.body.trim(); // Trim any extraneous whitespace

        if (responseBody.isEmpty) {
          throw FormatException('Empty response body');
        }

        var data = jsonDecode(responseBody);
        String userEmail = data['email'] ?? '';
        String userName = data['username'] ?? '';

        Navigator.pushReplacement( // we will not return to this screen again  on back navigation
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomeScreen(username: userName, email: userEmail),
          ),
        );
      } catch (e) {
        print('Error decoding JSON: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to decode response: $e')),
        );
      }
    } else {
      // Handle errors here, like showing a snackbar
      print('Error: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //extends bg color behind app bar / full screen
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // removes the shadow effect
        title: const Text(
          "SignUp",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          // enable scrolling
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(height: 20),
                reusableTextField("Enter Email Id", Icons.email_outlined, false,
                    _emailTextController),
                const SizedBox(height: 20),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(height: 20),
                signInsignUpButton(context, false, () {
                  // Call signUpUser when the button is pressed
                  signUpUser(
                    _userNameTextController.text,
                    _emailTextController.text,
                    _passwordTextController.text,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
