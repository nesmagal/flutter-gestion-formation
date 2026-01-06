// lib/screens/settings_screen.dart

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  String _language = "Français";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Paramètres",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF1565C0),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text("Mode sombre"),
            subtitle: Text("Activer le thème sombre"),
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
            },
            activeColor: Color(0xFF1565C0),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language, color: Color(0xFF1565C0)),
            title: Text("Langue"),
            subtitle: Text(_language),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Choisir la langue"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text("Français"),
                        onTap: () {
                          setState(() {
                            _language = "Français";
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text("English"),
                        onTap: () {
                          setState(() {
                            _language = "English";
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text("العربية"),
                        onTap: () {
                          setState(() {
                            _language = "العربية";
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.storage, color: Color(0xFF1565C0)),
            title: Text("Vider le cache"),
            subtitle: Text("Libérer de l'espace"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Vider le cache"),
                  content: Text("Êtes-vous sûr de vouloir vider le cache ?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Annuler"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Cache vidé")),
                        );
                      },
                      child: Text("Confirmer"),
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