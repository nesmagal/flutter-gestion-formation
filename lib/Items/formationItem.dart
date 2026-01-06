// lib/widgets/formationItem.dart

import 'package:flutter/material.dart';
import 'package:gestion_formations_flutter/Items/favorisItem.dart' show FavoriteButton;
import '../models/formationModel.dart';

class FormationItem extends StatelessWidget {
  final FormationModel formation;
  final VoidCallback? onTap;

  const FormationItem({
    Key? key,
    required this.formation,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 200,
        margin: EdgeInsets.only(right: 15),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image avec badges
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: _buildImage(),
                ),
                // Badge COMPLET
                if (formation.isComplete)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "COMPLET",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                // Bouton favori
                Positioned(
                  top: 8,
                  right: 8,
                  child: FavoriteButton(
                    formation: formation,
                    size: 20,
                    showBackground: true,
                  ),
                ),
              ],
            ),

            // Contenu de la carte avec padding réduit
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Titre
                  Text(
                    formation.titre,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),

                  // Description
                  Text(
                    formation.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6),

                  // Rating et étudiants
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      SizedBox(width: 4),
                      Text(
                        formation.rating.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.people, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          formation.students.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            height: 1,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour construire l'image (assets ou network)
  Widget _buildImage() {
    final isNetwork = formation.imageUrl.startsWith('http://') || 
                      formation.imageUrl.startsWith('https://');

    if (isNetwork) {
      return Image.network(
        formation.imageUrl,
        height: 110,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 110,
            color: Colors.grey[200],
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      );
    } else {
      return Image.asset(
        formation.imageUrl,
        height: 110,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      );
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 110,
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image, size: 40, color: Colors.grey[600]),
          SizedBox(height: 5),
          Text(
            "Image introuvable",
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}