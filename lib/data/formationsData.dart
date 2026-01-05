// lib/data/formationsData.dart

import '../models/formationModel.dart';

class FormationsData {
  static final List<FormationModel> formations = [
    // Développement Mobile
    FormationModel(
      titre: "Flutter Development Avancé",
      description: "Maîtrisez Flutter pour créer des applications mobiles iOS et Android performantes. Architecture MVVM, gestion d'état avec Provider et Riverpod, intégration Firebase, animations avancées.",
      nomFormateur: "Ahmed Ben Salem",
      domaine: "Mobile",
      categorie: "Développement Mobile",
      prix: 399.99,
      capacite: 30,
      imageUrl: "assets/images/flutter-logo-sharing.png",
      rating: 4.8,
      students: 25,
    ),
    FormationModel(
      titre: "React Native Expert",
      description: "Développement d'applications mobiles avec React Native. Navigation, Redux, API REST, notifications push, et déploiement sur App Store et Google Play.",
      nomFormateur: "Mohamed Arbi",
      domaine: "Mobile",
      categorie: "Développement Mobile",
      prix: 379.99,
      capacite: 25,
      imageUrl: "assets/images/flutter-logo-sharing.png",
      rating: 4.6,
      students: 20,
    ),

    // Développement Web
    FormationModel(
      titre: "Full Stack JavaScript",
      description: "Formation complète Full Stack avec Node.js, Express, React, MongoDB. Créez des applications web modernes from scratch jusqu'au déploiement.",
      nomFormateur: "Sami Bouaziz",
      domaine: "Web",
      categorie: "Développement Web",
      prix: 449.99,
      capacite: 35,
      imageUrl: "assets/images/ui_ux.jpg",
      rating: 4.9,
      students: 32,
    ),
    FormationModel(
      titre: "Laravel & Vue.js Expert",
      description: "Développement d'applications web professionnelles avec Laravel et Vue.js. API RESTful, authentification, testing, et déploiement.",
      nomFormateur: "Yasmine Trabelsi",
      domaine: "Web",
      categorie: "Développement Web",
      prix: 429.99,
      capacite: 30,
      imageUrl: "assets/images/ui_ux.jpg",
      rating: 4.7,
      students: 28,
    ),

    // Intelligence Artificielle
    FormationModel(
      titre: "Machine Learning avec Python",
      description: "Introduction au Machine Learning : algorithmes supervisés et non supervisés, réseaux de neurones, TensorFlow et PyTorch. Projets réels inclus.",
      nomFormateur: "Dr. Karim Mansouri",
      domaine: "IA",
      categorie: "Intelligence Artificielle",
      prix: 499.99,
      capacite: 20,
      imageUrl: "assets/images/flutter-logo-sharing.png",
      rating: 4.9,
      students: 18,
    ),
    FormationModel(
      titre: "Deep Learning & Computer Vision",
      description: "Apprentissage profond et vision par ordinateur. CNN, RNN, YOLO, détection d'objets, reconnaissance faciale avec TensorFlow et Keras.",
      nomFormateur: "Dr. Ines Gharbi",
      domaine: "IA",
      categorie: "Intelligence Artificielle",
      prix: 549.99,
      capacite: 18,
      imageUrl: "assets/images/flutter-logo-sharing.png",
      rating: 4.8,
      students: 15,
    ),

    // Data Science
    FormationModel(
      titre: "Data Science Complet",
      description: "Formation complète en Data Science : Python, Pandas, NumPy, visualisation, statistiques, machine learning, et projets end-to-end.",
      nomFormateur: "Nadia Chebbi",
      domaine: "Data",
      categorie: "Data Science",
      prix: 469.99,
      capacite: 25,
      imageUrl: "assets/images/Digital-Marketing.jpg",
      rating: 4.7,
      students: 22,
    ),

    // Design UI/UX
    FormationModel(
      titre: "UI/UX Design Professionnel",
      description: "Design d'interfaces modernes avec Figma. User research, wireframing, prototypage, design systems, et tests utilisateurs.",
      nomFormateur: "Fatma Mansouri",
      domaine: "Design",
      categorie: "Design UI/UX",
      prix: 349.99,
      capacite: 28,
      imageUrl: "assets/images/ui_ux.jpg",
      rating: 4.8,
      students: 24,
    ),
    FormationModel(
      titre: "Design d'Interfaces Mobiles",
      description: "Spécialisation design mobile : iOS et Android guidelines, responsive design, micro-interactions, et Design Thinking.",
      nomFormateur: "Salma Dhouib",
      domaine: "Design",
      categorie: "Design UI/UX",
      prix: 329.99,
      capacite: 22,
      imageUrl: "assets/images/ui_ux.jpg",
      rating: 4.6,
      students: 20,
    ),

    // Marketing Digital
    FormationModel(
      titre: "Marketing Digital 360°",
      description: "Stratégie marketing digitale complète : SEO, SEA, social media, content marketing, email marketing, et analytics. Certifications Google incluses.",
      nomFormateur: "Karim Trabelsi",
      domaine: "Marketing",
      categorie: "Marketing Digital",
      prix: 389.99,
      capacite: 40,
      imageUrl: "assets/images/Digital-Marketing.jpg",
      rating: 4.7,
      students: 38,
    ),

    // DevOps
    FormationModel(
      titre: "DevOps Engineer",
      description: "Formation DevOps complète : Docker, Kubernetes, CI/CD avec Jenkins/GitLab, monitoring avec Prometheus, automatisation avec Ansible.",
      nomFormateur: "Youssef Gharbi",
      domaine: "DevOps",
      categorie: "DevOps",
      prix: 479.99,
      capacite: 22,
      imageUrl: "assets/images/flutter-logo-sharing.png",
      rating: 4.8,
      students: 20,
    ),

    // Test & QA
    FormationModel(
      titre: "Test Automation Expert",
      description: "Automatisation des tests : Selenium, Cypress, Jest, tests unitaires, d'intégration et end-to-end. CI/CD et bonnes pratiques.",
      nomFormateur: "Rim Sassi",
      domaine: "QA",
      categorie: "Test & QA",
      prix: 359.99,
      capacite: 25,
      imageUrl: "assets/images/ui_ux.jpg",
      rating: 4.6,
      students: 22,
    ),

    // Cybersécurité
    FormationModel(
      titre: "Cybersécurité & Ethical Hacking",
      description: "Sécurité informatique : tests de pénétration, sécurité réseau, cryptographie, sécurité web (OWASP), et réponse aux incidents.",
      nomFormateur: "Mehdi Hamdi",
      domaine: "Sécurité",
      categorie: "Cybersécurité",
      prix: 529.99,
      capacite: 18,
      imageUrl: "assets/images/flutter-logo-sharing.png",
      rating: 4.9,
      students: 16,
    ),

    // Cloud Computing
    FormationModel(
      titre: "AWS Solutions Architect",
      description: "Architecture cloud sur AWS : EC2, S3, Lambda, RDS, VPC, CloudFormation. Préparation à la certification AWS Solutions Architect.",
      nomFormateur: "Amir Abidi",
      domaine: "Cloud",
      categorie: "Cloud Computing",
      prix: 499.99,
      capacite: 24,
      imageUrl: "assets/images/Digital-Marketing.jpg",
      rating: 4.8,
      students: 22,
    ),

    // Business & Management
    FormationModel(
      titre: "Product Management IT",
      description: "Gestion de produits tech : roadmap, user stories, méthodes Agile/Scrum, analytics produit, et stratégie go-to-market.",
      nomFormateur: "Amira Sassi",
      domaine: "Management",
      categorie: "Business & Management",
      prix: 419.99,
      capacite: 30,
      imageUrl: "assets/images/ui_ux.jpg",
      rating: 4.7,
      students: 26,
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