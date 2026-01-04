// lib/screens/accueil_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_formations_flutter/Items/categoryItem.dart';
import 'package:gestion_formations_flutter/Items/formationItem.dart';
import '../models/categoryModel.dart';
import '../data/formationsData.dart';
import 'categoryFormationsScreen.dart';

class AccueilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? "Utilisateur";

    // Liste des catégories
    final List<CategoryModel> categories = [
      CategoryModel(
        title: "Développement",
        icon: Icons.code,
        color: Color(0xFF2196F3), // Bleu
      ),
      CategoryModel(
        title: "Design",
        icon: Icons.brush,
        color: Color(0xFF9C27B0), // Violet
      ),
      CategoryModel(
        title: "Marketing",
        icon: Icons.campaign,
        color: Color(0xFFFF9800), // Orange
      ),
      CategoryModel(
        title: "Business",
        icon: Icons.business_center,
        color: Color(0xFF4CAF50), // Vert
      ),
    ];

    // Récupérer les formations populaires
    final formations = FormationsData.getPopularFormations(limit: 5);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header avec gradient bleu
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1976D2),
                      Color(0xFF2196F3),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre
                    Text(
                      "Gestionnaire de Formations",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    
                    // Barre de recherche
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Rechercher une formation...",
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 15,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[400],
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                        onChanged: (query) {
                          final results = FormationsData.searchFormations(query);
                          print("${results.length} résultats pour: $query");
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 25),

              // Section Catégories
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Catégories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "${FormationsData.formations.length} formations",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              // Grille de catégories
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final count = FormationsData.getFormationsCountByCategorie(
                      category.title,
                    );

                    return CategoryItem(
                      category: category,
                      formationsCount: count,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryFormationsScreen(
                              category: category,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 30),

              // Section Formations populaires
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Formations populaires",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        print("Voir toutes les formations");
                      },
                      child: Text(
                        "Voir tout",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              // Liste de formations populaires
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  itemCount: formations.length,
                  itemBuilder: (context, index) {
                    return FormationItem(
                      formation: formations[index],
                      onTap: () {
                        print("Formation cliquée: ${formations[index].titre}");
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}