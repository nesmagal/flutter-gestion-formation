// lib/screens/security_screen.dart

import 'package:flutter/material.dart';
import 'change_password_screen.dart';

class SecurityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sécurité",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF1565C0),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.lock, color: Color(0xFF1565C0)),
            title: Text("Changer le mot de passe"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.verified_user, color: Color(0xFF1565C0)),
            title: Text("Authentification à deux facteurs"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Fonctionnalité à venir")),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.devices, color: Color(0xFF1565C0)),
            title: Text("Appareils connectés"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Fonctionnalité à venir")),
              );
            },
          ),
        ],
      ),
    );
  }
}