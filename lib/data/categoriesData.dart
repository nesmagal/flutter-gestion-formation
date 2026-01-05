// lib/data/categoriesData.dart

import 'package:flutter/material.dart';
import '../models/categoryModel.dart';

class CategoriesData {
  static final List<CategoryModel> categories = [
    CategoryModel(
      title: "Développement Mobile",
      icon: Icons.phone_android,
      color: Color(0xFF2196F3), // Bleu
    ),
    CategoryModel(
      title: "Développement Web",
      icon: Icons.web,
      color: Color(0xFF4CAF50), // Vert
    ),
    CategoryModel(
      title: "Intelligence Artificielle",
      icon: Icons.psychology,
      color: Color(0xFF9C27B0), // Violet
    ),
    CategoryModel(
      title: "Data Science",
      icon: Icons.analytics,
      color: Color(0xFF00BCD4), // Cyan
    ),
    CategoryModel(
      title: "Design UI/UX",
      icon: Icons.brush,
      color: Color(0xFFE91E63), // Rose
    ),
    CategoryModel(
      title: "Marketing Digital",
      icon: Icons.campaign,
      color: Color(0xFFFF9800), // Orange
    ),
    CategoryModel(
      title: "DevOps",
      icon: Icons.settings_suggest,
      color: Color(0xFF3F51B5), // Indigo
    ),
    CategoryModel(
      title: "Test & QA",
      icon: Icons.bug_report,
      color: Color(0xFFFF5722), // Rouge-Orange
    ),
    CategoryModel(
      title: "Cybersécurité",
      icon: Icons.security,
      color: Color(0xFF607D8B), // Gris-Bleu
    ),
    CategoryModel(
      title: "Cloud Computing",
      icon: Icons.cloud,
      color: Color(0xFF009688), // Teal
    ),
    CategoryModel(
      title: "Business & Management",
      icon: Icons.business_center,
      color: Color(0xFF795548), // Marron
    ),
    CategoryModel(
      title: "Blockchain",
      icon: Icons.currency_bitcoin,
      color: Color(0xFFFFC107), // Ambre
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