// lib/services/inscriptionsService.dart

import 'package:firebase_auth/firebase_auth.dart';
import '../models/inscriptionModel.dart';
import '../models/formationModel.dart';

class InscriptionsService {
  // Liste locale des inscriptions (à remplacer par Firebase)
  static final List<InscriptionModel> _inscriptions = [];

  // Ajouter une inscription
  static void addInscription(InscriptionModel inscription) {
    _inscriptions.add(inscription);
    print("✅ Inscription enregistrée: ${inscription.formationTitre}");
  }

  // Obtenir toutes les inscriptions de l'utilisateur connecté
  static List<InscriptionModel> getUserInscriptions() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];
    
    return _inscriptions
        .where((i) => i.userId == user.uid)
        .toList();
  }

  // Vérifier si l'utilisateur est inscrit à une formation
  static bool isEnrolled(String formationTitre) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    
    return _inscriptions.any(
      (i) => i.userId == user.uid && i.formationTitre == formationTitre,
    );
  }

  // Obtenir une inscription spécifique
  static InscriptionModel? getInscription(String formationTitre) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    
    try {
      return _inscriptions.firstWhere(
        (i) => i.userId == user.uid && i.formationTitre == formationTitre,
      );
    } catch (e) {
      return null;
    }
  }

  // Annuler une inscription
  static void cancelInscription(String inscriptionId) {
    _inscriptions.removeWhere((i) => i.id == inscriptionId);
    print("❌ Inscription annulée: $inscriptionId");
  }

  // Obtenir le nombre d'inscriptions
  static int getInscriptionsCount() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return 0;
    
    return _inscriptions.where((i) => i.userId == user.uid).length;
  }

  // Charger les inscriptions depuis Firebase (à implémenter)
  static Future<void> loadInscriptions() async {
    // TODO: Charger depuis Firebase
    // final user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   final snapshot = await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(user.uid)
    //       .collection('inscriptions')
    //       .get();
    //   
    //   _inscriptions.clear();
    //   for (var doc in snapshot.docs) {
    //     _inscriptions.add(InscriptionModel.fromMap(doc.data()));
    //   }
    // }
    
    print("📥 Inscriptions chargées: ${_inscriptions.length}");
  }

  // Obtenir les inscriptions par statut
  static List<InscriptionModel> getInscriptionsByStatus(String statut) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];
    
    return _inscriptions
        .where((i) => i.userId == user.uid && i.statut == statut)
        .toList();
  }

  // Mettre à jour le statut d'une inscription
  static void updateStatus(String inscriptionId, String newStatus) {
    final index = _inscriptions.indexWhere((i) => i.id == inscriptionId);
    if (index != -1) {
      // Créer une nouvelle inscription avec le nouveau statut
      final oldInscription = _inscriptions[index];
      final updatedInscription = InscriptionModel(
        id: oldInscription.id,
        userId: oldInscription.userId,
        formationId: oldInscription.formationId,
        formationTitre: oldInscription.formationTitre,
        nom: oldInscription.nom,
        prenom: oldInscription.prenom,
        email: oldInscription.email,
        telephone: oldInscription.telephone,
        niveauEtude: oldInscription.niveauEtude,
        motivation: oldInscription.motivation,
        dateInscription: oldInscription.dateInscription,
        statut: newStatus,
      );
      _inscriptions[index] = updatedInscription;
      print("📝 Statut mis à jour: $newStatus");
    }
  }
}