
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_formations_flutter/Items/FormationItem.dart';
import 'package:gestion_formations_flutter/Items/categoryItem.dart';
import '../models/categoryModel.dart';
import '../models/formationModel.dart';


class AccueilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? "Utilisateur";

    // Liste des catégories
    final List<CategoryModel> categories = [
      CategoryModel(
        title: "Développement",
        icon: Icons.code,
        color: Colors.blue,
      ),
      CategoryModel(
        title: "Design",
        icon: Icons.design_services,
        color: Colors.purple,
      ),
      CategoryModel(
        title: "Marketing",
        icon: Icons.campaign,
        color: Colors.orange,
      ),
      CategoryModel(
        title: "Business",
        icon: Icons.business_center,
        color: Colors.green,
      ),
    ];

    // Liste des formations
    final List<FormationModel> formations = [
      FormationModel(
        titre: "Flutter Development",
        description: "Apprenez Flutter de A à Z",
        nomFormateur: "Ahmed Ben Salem",
        domaine: "Développement",
        prix: 299.99,
        capacite: 30,
        imageUrl: "assets/images/flutter-logo-sharing.png",
        rating: 4.5,
        students: 120,
      ),
      FormationModel(
        titre: "UI/UX Design",
        description: "Design moderne avec Figma",
        nomFormateur: "Fatma Mansouri",
        domaine: "Design",
        prix: 199.99,
        capacite: 25,
        imageUrl: "assets/images/ui_ux.jpg",
        rating: 4.8,
        students: 85,
      ),
      FormationModel(
        titre: "Digital Marketing",
        description: "Stratégies marketing 2024",
        nomFormateur: "Karim Trabelsi",
        domaine: "Marketing",
        prix: 249.99,
        capacite: 40,
        imageUrl: "assets/images/Digital-Marketing.jpg",
        rating: 4.6,
        students: 200,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Gestionnaire de Formations",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1565C0),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header avec gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1565C0),
                    Color(0xFF1E88E5),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bonjour,",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Barre de recherche
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Rechercher une formation...",
                        prefixIcon: Icon(Icons.search, color: Color(0xFF1565C0)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      onChanged: (query) {
                        print("Recherche: $query");
                        // Vous pouvez ajouter la logique de recherche ici
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Section Catégories
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Catégories",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 15),

            // Grille de catégories
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1.3,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryItem(
                    category: categories[index],
                    onTap: () {
                      print("Catégorie cliquée: ${categories[index].title}");
                      // Navigation vers la page de la catégorie
                      // Navigator.push(context, ...);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 25),

            // Section Formations populaires
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Formations populaires",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print("Voir toutes les formations");
                      // Navigation vers la liste complète
                    },
                    child: Text("Voir tout"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Liste de formations avec ListView.builder
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: formations.length,
                itemBuilder: (context, index) {
                  return FormationItem(
                    formation: formations[index],
                    onTap: () {
                      print("Formation cliquée: ${formations[index].titre}");
                      // Navigation vers les détails de la formation
                      // Navigator.push(context, ...);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}