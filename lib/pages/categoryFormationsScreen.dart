// lib/screens/categoryFormationsScreen.dart

import 'package:flutter/material.dart';
import '../models/categoryModel.dart';
import '../data/formationsData.dart';

class CategoryFormationsScreen extends StatelessWidget {
  final CategoryModel category;

  const CategoryFormationsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupérer les formations de cette catégorie
    final formations = FormationsData.getFormationsByCategorie(category.title);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          category.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: category.color,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header avec informations de la catégorie
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: category.color,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(
                  category.icon,
                  size: 60,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  "${formations.length} formation${formations.length > 1 ? 's' : ''} disponible${formations.length > 1 ? 's' : ''}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Liste des formations
          Expanded(
            child: formations.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: formations.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: _buildFormationCardFull(
                          context,
                          formations[index],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Widget pour afficher une formation en mode liste complète
  Widget _buildFormationCardFull(BuildContext context, formation) {
    return InkWell(
      onTap: () {
        print("Formation cliquée: ${formation.titre}");
        // Navigation vers les détails
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
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
            // Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: Image.asset(
                formation.imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey[300],
                    child: Icon(Icons.image, color: Colors.grey),
                  );
                },
              ),
            ),

            // Contenu
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre
                    Text(
                      formation.titre,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),

                    // Formateur
                    Row(
                      children: [
                        Icon(Icons.person, size: 14, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            formation.nomFormateur,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    // Prix et Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Prix
                        Text(
                          "${formation.prix.toStringAsFixed(0)} TND",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: category.color,
                          ),
                        ),
                        // Rating
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber),
                            SizedBox(width: 4),
                            Text(
                              formation.rating.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Places restantes
                    if (!formation.isComplete) ...[
                      SizedBox(height: 5),
                      Text(
                        "${formation.placesRestantes} places restantes",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    if (formation.isComplete) ...[
                      SizedBox(height: 5),
                      Text(
                        "COMPLET",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour état vide
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 20),
          Text(
            "Aucune formation disponible",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Revenez plus tard !",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}