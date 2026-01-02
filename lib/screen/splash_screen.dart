import 'package:flutter/material.dart';
import 'package:gestion_formations_flutter/auth/login_screen.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Redirection vers HomeScreen après 4 secondes
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Couleur de fond
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/Online_Learning_Platform.json',
              width: 250,
              height: 250,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 20),
            Text(
              "Gestion Des Formations",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}