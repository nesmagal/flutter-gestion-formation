// lib/data/formationsData.dart

import '../models/formationModel.dart';

class FormationsData {
  static final List<FormationModel> formations = [
    // Développement
    FormationModel(
      titre: "Flutter Development",
      description: "Apprenez Flutter de A à Z avec des projets pratiques. Maîtrisez la création d'applications mobiles multiplateformes avec Dart et Flutter. Ce cours couvre les widgets, la gestion d'état, Firebase, et bien plus encore.",
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
      description: "Analyse de données et Machine Learning avec Python. Apprenez Pandas, NumPy, Matplotlib et Scikit-learn pour devenir un expert en data science.",
      nomFormateur: "Ines Mejri",
      domaine: "Data Science",
      categorie: "Développement",
      prix: 349.99,
      capacite: 20,
      imageUrl: "assets/images/flutter-logo-sharing.png",
      rating: 4.7,
      students: 15,
    ),
    FormationModel(
      titre: "React Native Avancé",
      description: "Créez des applications mobiles performantes avec React Native. Navigation, API, animations et déploiement sur iOS et Android.",
      nomFormateur: "Mohamed Arbi",
      domaine: "Mobile",
      categorie: "Développement",
      prix: 279.99,
      capacite: 25,
      imageUrl: "assets/images/flutter-logo-sharing.png",
      rating: 4.4,
      students: 18,    
      ),

    // Design
    FormationModel(
      titre: "UI/UX Design avec Figma",
      description: "Design moderne avec Figma. Créez des interfaces professionnelles, des prototypes interactifs et des design systems complets.",
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
      description: "Techniques avancées de retouche photo, compositing et création graphique. Maîtrisez tous les outils de Photoshop pour devenir un expert.",
      nomFormateur: "Salma Dhouib",
      domaine: "Graphisme",
      categorie: "Design",
      prix: 189.99,
      capacite: 15,
      imageUrl: "assets/images/ui_ux.jpg",
      rating: 4.9,
      students: 12,
    ),

    // Marketing
    FormationModel(
      titre: "Digital Marketing 2024",
      description: "Stratégies marketing complètes : SEO, réseaux sociaux, publicité en ligne, email marketing et analytics. Devenez un expert du marketing digital.",
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
      description: "Optimisez votre visibilité en ligne avec les meilleures techniques SEO et stratégies de contenu. Google Analytics, Search Console et plus.",
      nomFormateur: "Nour Hamdi",
      domaine: "SEO",
      categorie: "Marketing",
      prix: 229.99,
      capacite: 30,
      imageUrl: "assets/images/Digital-Marketing.jpg",
      rating: 4.5,
      students: 25,
    ),

    // Business
    FormationModel(
      titre: "Gestion de Projet Agile",
      description: "Méthodes Scrum et Kanban pour gérer efficacement vos projets. Devenez Scrum Master certifié et managez des équipes performantes.",
      nomFormateur: "Youssef Gharbi",
      domaine: "Management",
      categorie: "Business",
      prix: 229.99,
      capacite: 35,
      imageUrl: "assets/images/flutter-logo-sharing.png",
      rating: 4.5,
      students: 30,
    ),
    FormationModel(
      titre: "Entrepreneuriat Digital",
      description: "Créez et développez votre startup. Business plan, levée de fonds, growth hacking et stratégies de croissance pour entrepreneurs.",
      nomFormateur: "Amira Sassi",
      domaine: "Startup",
      categorie: "Business",
      prix: 299.99,
      capacite: 20,
      imageUrl: "assets/images/flutter-logo-sharing.png",
      rating: 4.7,
      students: 15,
    ),

    // Photographie
    FormationModel(
      titre: "Photographie Professionnelle",
      description: "Maîtrisez l'art de la photographie : composition, lumière, retouche et équipement. Du débutant au professionnel.",
      nomFormateur: "Rami Chaabane",
      domaine: "Photo",
      categorie: "Photographie",
      prix: 279.99,
      capacite: 18,
      imageUrl: "assets/images/ui_ux.jpg",
      rating: 4.8,
      students: 14,
    ),

    // Musique
    FormationModel(
      titre: "Production Musicale",
      description: "Créez votre propre musique avec Ableton Live et Logic Pro. Composition, mixage, mastering et distribution.",
      nomFormateur: "Hichem Zarrouk",
      domaine: "Audio",
      categorie: "Musique",
      prix: 319.99,
      capacite: 15,
      imageUrl: "assets/images/flutter-logo-sharing.png",
      rating: 4.6,
      students: 12,
    ),

    // Santé & Fitness
    FormationModel(
      titre: "Coach Personnel Certifié",
      description: "Devenez coach sportif professionnel. Anatomie, nutrition, programmes d'entraînement et gestion de clientèle.",
      nomFormateur: "Sarra Bouaziz",
      domaine: "Fitness",
      categorie: "Santé & Fitness",
      prix: 399.99,
      capacite: 25,
      imageUrl: "assets/images/ui_ux.jpg",
      rating: 4.9,
      students: 20,
    ),

    // Langues
    FormationModel(
      titre: "Anglais des Affaires",
      description: "Perfectionnez votre anglais professionnel pour les réunions, présentations et négociations internationales.",
      nomFormateur: "Sarah Johnson",
      domaine: "Langues",
      categorie: "Langues",
      prix: 189.99,
      capacite: 30,
      imageUrl: "assets/images/flutter-logo-sharing.png",
      rating: 4.7,
      students: 28,
    ),
  ];

  // Filtrer par catégorie
  static List<FormationModel> getFormationsByCategorie(String categorie) {
    return formations
        .where((f) => f.categorie.toLowerCase() == categorie.toLowerCase())
        .toList();
  }

  // Formations populaires
  static List<FormationModel> getPopularFormations({int limit = 3}) {
    final sorted = List<FormationModel>.from(formations)
      ..sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(limit).toList();
  }

  // Recherche
  static List<FormationModel> searchFormations(String query) {
    final lowerQuery = query.toLowerCase();
    return formations.where((f) {
      return f.titre.toLowerCase().contains(lowerQuery) ||
          f.description.toLowerCase().contains(lowerQuery) ||
          f.categorie.toLowerCase().contains(lowerQuery) ||
          f.domaine.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // Formations disponibles
  static List<FormationModel> getFormationsDisponibles() {
    return formations.where((f) => !f.isComplete).toList();
  }

  // Nombre de formations par catégorie
  static int getFormationsCountByCategorie(String categorie) {
    return formations
        .where((f) => f.categorie.toLowerCase() == categorie.toLowerCase())
        .length;
  }
}