// lib/services/favoritesService.dart

import 'package:firebase_auth/firebase_auth.dart';
import '../models/formationModel.dart';

class FavoritesService {
  // Liste locale des favoris (à remplacer par Firebase plus tard)
  static final List<FormationModel> _favorites = [];

  // Ajouter une formation aux favoris
  static void addFavorite(FormationModel formation) {
    if (!isFavorite(formation.titre)) {
      _favorites.add(formation);
      
      // TODO: Sauvegarder dans Firebase
      // final user = FirebaseAuth.instance.currentUser;
      // if (user != null) {
      //   await FirebaseFirestore.instance
      //       .collection('users')
      //       .doc(user.uid)
      //       .collection('favorites')
      //       .doc(formation.titre)
      //       .set(formation.toMap());
      // }
      
      print("✅ Formation ajoutée aux favoris: ${formation.titre}");
    }
  }

  // Retirer une formation des favoris
  static void removeFavorite(String formationTitre) {
    _favorites.removeWhere((f) => f.titre == formationTitre);
    
    // TODO: Supprimer de Firebase
    // final user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(user.uid)
    //       .collection('favorites')
    //       .doc(formationTitre)
    //       .delete();
    // }
    
    print("Formation retirée des favoris: $formationTitre");
  }

  // Toggle favori
  static void toggleFavorite(FormationModel formation) {
    if (isFavorite(formation.titre)) {
      removeFavorite(formation.titre);
    } else {
      addFavorite(formation);
    }
  }

  // Vérifier si une formation est en favori
  static bool isFavorite(String formationTitre) {
    return _favorites.any((f) => f.titre == formationTitre);
  }

  // Obtenir tous les favoris
  static List<FormationModel> getFavorites() {
    return List.unmodifiable(_favorites);
  }

  // Obtenir le nombre de favoris
  static int getFavoritesCount() {
    return _favorites.length;
  }

  // Charger les favoris depuis Firebase (à implémenter)
  static Future<void> loadFavorites() async {
    // TODO: Charger depuis Firebase
    // final user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   final snapshot = await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(user.uid)
    //       .collection('favorites')
    //       .get();
    //   
    //   _favorites.clear();
    //   for (var doc in snapshot.docs) {
    //     _favorites.add(FormationModel.fromMap(doc.data()));
    //   }
    // }
    
    print("Favoris chargés: ${_favorites.length} formations");
  }

  // Vider les favoris
  static void clearFavorites() {
    _favorites.clear();
  }
}