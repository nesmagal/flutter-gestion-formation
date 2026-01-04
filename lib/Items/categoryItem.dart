// lib/widgets/categoryItem.dart

import 'package:flutter/material.dart';
import '../models/categoryModel.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;
  final int formationsCount;

  const CategoryItem({
    Key? key,
    required this.category,
    this.onTap,
    this.formationsCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Catégorie ${category.title} sélectionnée"),
            duration: Duration(seconds: 2),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Contenu principal
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icône avec fond coloré
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: category.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      category.icon,
                      size: 40,
                      color: category.color,
                    ),
                  ),
                  Spacer(),
                  // Titre
                  Text(
                    category.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            // Badge avec le nombre de formations
            if (formationsCount > 0)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: category.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: category.color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  constraints: BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                  ),
                  child: Center(
                    child: Text(
                      "$formationsCount",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}