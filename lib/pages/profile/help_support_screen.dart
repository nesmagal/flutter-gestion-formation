// lib/screens/help_support_screen.dart

import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Aide & Support",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF1565C0),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.question_answer, color: Color(0xFF1565C0)),
            title: Text("FAQ"),
            subtitle: Text("Questions fréquemment posées"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Page FAQ à venir")),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.contact_support, color: Color(0xFF1565C0)),
            title: Text("Contacter le support"),
            subtitle: Text("Envoyer un message"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("support@formations.com")),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info, color: Color(0xFF1565C0)),
            title: Text("À propos"),
            subtitle: Text("Version 1.0.0"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("À propos"),
                  content: Text("Application de gestion des formations\nVersion 1.0.0"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Fermer"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}