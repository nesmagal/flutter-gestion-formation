// lib/models/progressModel.dart

class ProgressModel {
  final String formationTitre;
  final double progressPercentage; // 0.0 à 1.0
  final int completedLessons;
  final int totalLessons;
  final DateTime lastAccess;
  final String currentLesson;

  ProgressModel({
    required this.formationTitre,
    required this.progressPercentage,
    required this.completedLessons,
    required this.totalLessons,
    required this.lastAccess,
    required this.currentLesson,
  });

  // Vérifier si la formation est terminée
  bool get isCompleted => progressPercentage >= 1.0;

  // Obtenir le nombre de leçons restantes
  int get remainingLessons => totalLessons - completedLessons;


}