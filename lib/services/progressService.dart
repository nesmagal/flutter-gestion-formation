// lib/services/progressService.dart

import '../models/progressModel.dart';

class ProgressService {
  // Données de progression simulées (à remplacer par Firebase)
  static final Map<String, ProgressModel> _progress = {
    "Flutter Development Avancé": ProgressModel(
      formationTitre: "Flutter Development Avancé",
      progressPercentage: 0.45,
      completedLessons: 9,
      totalLessons: 20,
      lastAccess: DateTime.now().subtract(Duration(days: 2)),
      currentLesson: "Gestion d'état avec Provider",
    ),
    "UI/UX Design Professionnel": ProgressModel(
      formationTitre: "UI/UX Design Professionnel",
      progressPercentage: 0.70,
      completedLessons: 14,
      totalLessons: 20,
      lastAccess: DateTime.now().subtract(Duration(hours: 5)),
      currentLesson: "Design Systems avancés",
    ),
    "Digital Marketing 360°": ProgressModel(
      formationTitre: "Digital Marketing 360°",
      progressPercentage: 0.20,
      completedLessons: 4,
      totalLessons: 20,
      lastAccess: DateTime.now().subtract(Duration(days: 7)),
      currentLesson: "Introduction au SEO",
    ),
  };

  // Obtenir la progression d'une formation
  static ProgressModel? getProgress(String formationTitre) {
    return _progress[formationTitre];
  }

  // Mettre à jour la progression
  static void updateProgress(ProgressModel progress) {
    _progress[progress.formationTitre] = progress;
    print("📈 Progression mise à jour: ${progress.formationTitre} - ${(progress.progressPercentage * 100).toStringAsFixed(0)}%");
  }

  // Obtenir toutes les progressions
  static List<ProgressModel> getAllProgress() {
    return _progress.values.toList();
  }

  // Vérifier si une formation a une progression
  static bool hasProgress(String formationTitre) {
    return _progress.containsKey(formationTitre);
  }

  // Initialiser la progression pour une nouvelle formation
  static void initializeProgress(String formationTitre, int totalLessons) {
    if (!hasProgress(formationTitre)) {
      _progress[formationTitre] = ProgressModel(
        formationTitre: formationTitre,
        progressPercentage: 0.0,
        completedLessons: 0,
        totalLessons: totalLessons,
        lastAccess: DateTime.now(),
        currentLesson: "Introduction",
      );
    }
  }

  // Marquer une leçon comme complétée
  static void completeLesson(String formationTitre) {
    final progress = getProgress(formationTitre);
    if (progress != null && progress.completedLessons < progress.totalLessons) {
      final newCompleted = progress.completedLessons + 1;
      final newProgress = ProgressModel(
        formationTitre: progress.formationTitre,
        progressPercentage: newCompleted / progress.totalLessons,
        completedLessons: newCompleted,
        totalLessons: progress.totalLessons,
        lastAccess: DateTime.now(),
        currentLesson: progress.currentLesson,
      );
      updateProgress(newProgress);
    }
  }
}