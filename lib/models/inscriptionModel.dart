// lib/models/inscriptionModel.dart

class InscriptionModel {
  final String id; // ID unique de l'inscription
  final String userId; // ID de l'utilisateur Firebase
  final String formationId; // ID de la formation
  final String formationTitre; // Titre de la formation
  final String nom;
  final String prenom;
  final String email;
  final String telephone;
  final String niveauEtude; // Niveau d'étude
  final String motivation; // Motivation pour la formation
  final DateTime dateInscription;
  final String statut; // "En attente", "Accepté", "Refusé"

  InscriptionModel({
    required this.id,
    required this.userId,
    required this.formationId,
    required this.formationTitre,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    required this.niveauEtude,
    required this.motivation,
    required this.dateInscription,
    this.statut = "En attente",
  });

  // Conversion en Map pour Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'formationId': formationId,
      'formationTitre': formationTitre,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'telephone': telephone,
      'niveauEtude': niveauEtude,
      'motivation': motivation,
      'dateInscription': dateInscription.toIso8601String(),
      'statut': statut,
    };
  }

  // Créer depuis Map (Firebase)
  factory InscriptionModel.fromMap(Map<String, dynamic> map) {
    return InscriptionModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      formationId: map['formationId'] ?? '',
      formationTitre: map['formationTitre'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      email: map['email'] ?? '',
      telephone: map['telephone'] ?? '',
      niveauEtude: map['niveauEtude'] ?? '',
      motivation: map['motivation'] ?? '',
      dateInscription: DateTime.parse(map['dateInscription']),
      statut: map['statut'] ?? 'En attente',
    );
  }
}