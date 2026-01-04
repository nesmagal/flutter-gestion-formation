import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Mes Favoris",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildFavoriteItem(
            "Flutter Development",
            "Formation complète Flutter",
            "4.5",
            Icons.code,
            Colors.blue,
          ),
          SizedBox(height: 15),
          _buildFavoriteItem(
            "UI/UX Design",
            "Design moderne avec Figma",
            "4.8",
            Icons.design_services,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteItem(String title, String subtitle, String rating, IconData icon, Color color) {
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    SizedBox(width: 4),
                    Text(rating, style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}