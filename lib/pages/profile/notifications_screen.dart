// lib/screens/notifications_screen.dart

import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _formationUpdates = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF1565C0),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text("Notifications par email"),
            subtitle: Text("Recevoir des emails de mise à jour"),
            value: _emailNotifications,
            onChanged: (value) {
              setState(() {
                _emailNotifications = value;
              });
            },
            activeColor: Color(0xFF1565C0),
          ),
          Divider(),
          SwitchListTile(
            title: Text("Notifications push"),
            subtitle: Text("Alertes sur votre appareil"),
            value: _pushNotifications,
            onChanged: (value) {
              setState(() {
                _pushNotifications = value;
              });
            },
            activeColor: Color(0xFF1565C0),
          ),
          Divider(),
          SwitchListTile(
            title: Text("Mises à jour des formations"),
            subtitle: Text("Nouvelles formations disponibles"),
            value: _formationUpdates,
            onChanged: (value) {
              setState(() {
                _formationUpdates = value;
              });
            },
            activeColor: Color(0xFF1565C0),
          ),
        ],
      ),
    );
  }
}