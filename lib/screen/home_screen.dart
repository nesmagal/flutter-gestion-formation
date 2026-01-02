import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tableau de Bord"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text(
          "Bienvenue dans votre gestionnaire de formations",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}