import 'package:flutter/material.dart';

class MesFormationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Mes Formations",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildFormationItem(
            "Flutter Development",
            "Progression: 45%",
            0.45,
            Colors.blue,
            Icons.code,
          ),
          SizedBox(height: 15),
          _buildFormationItem(
            "UI/UX Design",
            "Progression: 70%",
            0.70,
            Colors.purple,
            Icons.design_services,
          ),
          SizedBox(height: 15),
          _buildFormationItem(
            "Digital Marketing",
            "Progression: 20%",
            0.20,
            Colors.orange,
            Icons.campaign,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Ajouter une nouvelle formation")),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF1565C0),
      ),
    );
  }

  Widget _buildFormationItem(String title, String subtitle, double progress, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 30, color: color),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    color: color,
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}