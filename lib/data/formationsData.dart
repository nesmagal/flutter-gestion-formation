// lib/data/formationsData.dart

import '../models/formationModel.dart';

class FormationsData {
  static final List<FormationModel> formations = [
    // Formations Développement
    FormationModel(
      titre: "Flutter Development",
      description: "Apprenez Flutter de A à Z avec des projets pratiques",
      nomFormateur: "Ahmed Ben Salem",
      domaine: "Mobile",
      categorie: "Développement",
      prix: 299.99,
      capacite: 30,
      imageUrl: "assets/images/flutter-logo-sharing.png",
      rating: 4.5,
      students: 25,
    ),
    FormationModel(
      titre: "Python pour Data Science",
      description: "Analyse de données et Machine Learning",
      nomFormateur: "Ines Mejri",
      domaine: "Data Science",
      categorie: "Développement",
      prix: 349.99,
      capacite: 20,
      imageUrl: "assets/images/python.png",
      rating: 4.7,
      students: 15,
    ),
    FormationModel(
      titre: "React Native Avancé",
      description: "Créez des applications mobiles performantes",
      nomFormateur: "Mohamed Arbi",
      domaine: "Mobile",
      categorie: "Développement",
      prix: 279.99,
      capacite: 25,
      imageUrl: "assets/images/reactnative.jpg",
      rating: 4.4,
      students: 18,
    ),
    FormationModel(
      titre: "React Native",
      description: "Créez des applications mobiles",
      nomFormateur: "Mohamed Arbi",
      domaine: "Mobile",
      categorie: "Développement",
      prix: 270,
      capacite: 15,
      imageUrl: "assets/images/reactnative.jpg",
      rating: 4.4,
      students: 20,
    ),

    // Formations Design
    FormationModel(
      titre: "UI/UX Design",
      description: "Design moderne avec Figma",
      nomFormateur: "Fatma Mansouri",
      domaine: "Interface Design",
      categorie: "Design",
      prix: 199.99,
      capacite: 25,
      imageUrl: "assets/images/ui_ux.jpg",
      rating: 4.8,
      students: 20,
    ),
    FormationModel(
      titre: "Photoshop Professionnel",
      description: "Techniques avancées de retouche photo",
      nomFormateur: "Salma Dhouib",
      domaine: "Graphisme",
      categorie: "Design",
      prix: 189.99,
      capacite: 15,
      imageUrl: "assets/images/ui_ux1.avif",
      rating: 4.9,
      students: 12,
    ),

    // Formations Marketing
    FormationModel(
      titre: "Digital Marketing",
      description: "Stratégies marketing 2024",
      nomFormateur: "Karim Trabelsi",
      domaine: "Marketing Digital",
      categorie: "Marketing",
      prix: 249.99,
      capacite: 40,
      imageUrl: "assets/images/Digital-Marketing.jpg",
      rating: 4.6,
      students: 38,
    ),
    FormationModel(
      titre: "SEO & Content Marketing",
      description: "Optimisez votre visibilité en ligne",
      nomFormateur: "Nour Hamdi",
      domaine: "SEO",
      categorie: "Marketing",
      prix: 229.99,
      capacite: 30,
      imageUrl: "assets/images/Business-Digital-Marketing.png",
      rating: 4.5,
      students: 25,
    ),

    // Formations Business
    FormationModel(
      titre: "Gestion de Projet Agile",
      description: "Méthodes Scrum et Kanban",
      nomFormateur: "Youssef Gharbi",
      domaine: "Management",
      categorie: "Business",
      prix: 229.99,
      capacite: 35,
      imageUrl: "assets/images/Business-Digital-Marketing.png",
      rating: 4.5,
      students: 30,
    ),
    FormationModel(
      titre: "Entrepreneuriat Digital",
      description: "Créez et développez votre startup",
      nomFormateur: "Amira Sassi",
      domaine: "Startup",
      categorie: "Business",
      prix: 299.99,
      capacite: 20,
      imageUrl: "assets/images/marketing.webp",
      rating: 4.7,
      students: 15,
    ),
  ];

  // Filtrer les formations par catégorie
  static List<FormationModel> getFormationsByCategorie(String categorie) {
    return formations
        .where((f) => f.categorie.toLowerCase() == categorie.toLowerCase())
        .toList();
  }

  // Obtenir les formations populaires
  static List<FormationModel> getPopularFormations({int limit = 3}) {
    final sorted = List<FormationModel>.from(formations)
      ..sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(limit).toList();
  }

  // Rechercher des formations
  static List<FormationModel> searchFormations(String query) {
    final lowerQuery = query.toLowerCase();
    return formations.where((f) {
      return f.titre.toLowerCase().contains(lowerQuery) ||
          f.description.toLowerCase().contains(lowerQuery) ||
          f.categorie.toLowerCase().contains(lowerQuery) ||
          f.domaine.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // Obtenir les formations disponibles
  static List<FormationModel> getFormationsDisponibles() {
    return formations.where((f) => !f.isComplete).toList();
  }

  // Statistiques
  static int getFormationsCountByCategorie(String categorie) {
    return formations
        .where((f) => f.categorie.toLowerCase() == categorie.toLowerCase())
        .length;
  }
}