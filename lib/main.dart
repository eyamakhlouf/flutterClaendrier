import 'package:flutter/material.dart';
import 'package:mycalender/screens/timetable_screen.dart';
import 'screens/login_screen.dart';
import 'shared_preferences_helper.dart'; // Import SharedPreferencesHelper

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timetable App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Use SplashScreen for authentication checks
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication(); // Perform authentication check on splash screen load
  }

  Future<void> _checkAuthentication() async {
    // Check if a token exists in storage
    final token = await SharedPreferencesHelper.getToken();

    if (token != null && !_isTokenExpired(token)) {
      // If a valid token is found, navigate to TimetableScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TimetableScreen()),
      );
    } else {
      // Otherwise, navigate to LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  bool _isTokenExpired(String token) {
    return false; // Replace with real expiration validation if necessary
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()), // Loading indicator
    );
  }
}
