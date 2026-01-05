import 'package:flutter/material.dart';
import '../models/categoryModel.dart';

class CategoriesData {
  static final List<CategoryModel> categories = [
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
    CategoryModel(
      title: "Photographie",
      icon: Icons.camera_alt,
      color: Color(0xFFE91E63), // Rose
    ),
    CategoryModel(
      title: "Musique",
      icon: Icons.music_note,
      color: Color(0xFF00BCD4), // Cyan
    ),
    CategoryModel(
      title: "Santé & Fitness",
      icon: Icons.fitness_center,
      color: Color(0xFFFF5722), // Rouge-Orange
    ),
    CategoryModel(
      title: "Langues",
      icon: Icons.language,
      color: Color(0xFF3F51B5), // Indigo
    ),
    CategoryModel(
      title: "Cuisine",
      icon: Icons.restaurant,
      color: Color(0xFFFFEB3B), // Jaune
    ),
    CategoryModel(
      title: "Finance",
      icon: Icons.attach_money,
      color: Color(0xFF009688), // Teal
    ),
  ];

  // Obtenir une catégorie par titre
  static CategoryModel? getCategoryByTitle(String title) {
    try {
      return categories.firstWhere(
        (cat) => cat.title.toLowerCase() == title.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // Obtenir toutes les catégories
  static List<CategoryModel> getAllCategories() {
    return categories;
  }
}