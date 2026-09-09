import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF2C6975);
const Color kSecondaryColor = Color(0xFF68B2A0);
const Color kAccentColor = Color(0xFFCDE0C9);
const Color kBackgroundColor = Color(0xFFFFFFFF);

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simulate initialization process with delay
    _initApp();
  }

  void _initApp() async {
    // Add a delay to simulate loading or initialization process
    await Future.delayed(const Duration(seconds: 3));
    // Navigate to home screen after initialization
    Navigator.pushNamed(context, 'home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor, // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular logo with CircleAvatar
            CircleAvatar(
              radius: 80, // Size of the circle (adjust as needed)
              backgroundImage: AssetImage('assets/logo.png'), // Path to your logo image
              backgroundColor: Colors.transparent, // Make the background transparent
            ),
            const SizedBox(height: 20), // Optional spacing
            // Slogan text below the logo
            Text(
              "Grow Smarter, Reach Further",
              style: TextStyle(
                fontSize: 24,
                color: kPrimaryColor, // Use primary color for text
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // Optional spacing
            // Optional: Add a loading indicator or text
            CircularProgressIndicator(
              color: kSecondaryColor, // Use secondary color for the loading spinner
            ),
          ],
        ),
      ),
    );
  }
}
