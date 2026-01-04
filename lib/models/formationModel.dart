// lib/models/formationModel.dart

class FormationModel {
  final String titre;
  final String description;
  final String nomFormateur;
  final String domaine;
  final String categorie; // NOUVEAU: pour lier avec CategoryModel
  final double prix;
  final int capacite;
  final String imageUrl;
  final double rating;
  final int students;

  FormationModel({
    required this.titre,
    required this.description,
    required this.nomFormateur,
    required this.domaine,
    required this.categorie, // NOUVEAU
    required this.prix,
    required this.capacite,
    required this.imageUrl,
    this.rating = 0.0,
    this.students = 0,
  });

  // Vérifier si la formation est complète
  bool get isComplete => students >= capacite;

  // Calculer le pourcentage de remplissage
  double get fillPercentage => (students / capacite * 100).clamp(0, 100);

  // Obtenir les places restantes
  int get placesRestantes => (capacite - students).clamp(0, capacite);

}