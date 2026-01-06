// lib/screens/favoriteScreen.dart

import 'package:flutter/material.dart';
import 'package:gestion_formations_flutter/Items/favorisItem.dart';
import 'package:gestion_formations_flutter/pages/formations/formationDetailsScreen.dart';
import '../services/favoritesService.dart';
import '../data/categoriesData.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesService.getFavorites();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Favoris",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header avec gradient
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
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(
                    Icons.favorite,
                    size: 60,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Mes Favoris",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${favorites.length} formation${favorites.length > 1 ? 's' : ''} sauvegardée${favorites.length > 1 ? 's' : ''}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Liste des favoris
            Expanded(
              child: favorites.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final formation = favorites[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: _buildFavoriteCard(formation),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(formation) {
    final category = CategoriesData.getCategoryByTitle(formation.categorie);
    final categoryColor = category?.color ?? Colors.blue;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormationDetailsScreen(
              formation: formation,
            ),
          ),
        ).then((_) {
          // Rafraîchir la liste après retour
          setState(() {});
        });
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: Offset(0, 4),
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
                width: 110,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 110,
                    height: 140,
                    color: Colors.grey[300],
                    child: Icon(Icons.image, size: 40, color: Colors.grey),
                  );
                },
              ),
            ),

            // Contenu
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge catégorie
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: categoryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        formation.categorie,
                        style: TextStyle(
                          fontSize: 11,
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Titre
                    Text(
                      formation.titre,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6),

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
                    SizedBox(height: 10),

                    // Prix et rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rating
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber),
                            SizedBox(width: 4),
                            Text(
                              formation.rating.toString(),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        // Prix
                        Text(
                          "${formation.prix.toStringAsFixed(0)} TND",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: categoryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bouton favori
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: FavoriteButton(
                formation: formation,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 100,
            color: Colors.grey[300],
          ),
          SizedBox(height: 20),
          Text(
            "Aucun favori pour le moment",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Explorez les formations et ajoutez-les à vos favoris en appuyant sur ❤️",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}