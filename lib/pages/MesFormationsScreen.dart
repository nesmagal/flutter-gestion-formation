// lib/screens/mesFormationsScreen.dart

import 'package:flutter/material.dart';
import 'package:gestion_formations_flutter/pages/formations/formationDetailsScreen.dart';
import '../services/inscriptionsService.dart';
import '../services/progressService.dart';
import '../data/formationsData.dart';
import '../data/categoriesData.dart';

class MesFormationsScreen extends StatefulWidget {
  @override
  _MesFormationsScreenState createState() => _MesFormationsScreenState();
}

class _MesFormationsScreenState extends State<MesFormationsScreen> {
  // Le TabController a été supprimé car on n'utilise plus d'onglets

  @override
  Widget build(BuildContext context) {
    final inscriptions = InscriptionsService.getUserInscriptions();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Mes Formations",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header (Simplifié sans TabBar)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1976D2),
                    Color(0xFF2196F3),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                children: [
                  Icon(
                    Icons.school,
                    size: 60,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Mes Formations",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${inscriptions.length} formation${inscriptions.length > 1 ? 's' : ''} au total",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Liste unique de toutes les formations
            Expanded(
              child: inscriptions.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: inscriptions.length,
                      itemBuilder: (context, index) {
                        final inscription = inscriptions[index];
                        final formation = FormationsData.formations.firstWhere(
                          (f) => f.titre == inscription.formationTitre,
                          orElse: () => FormationsData.formations[0],
                        );
                        final progress = ProgressService.getProgress(
                            inscription.formationTitre);
                        final category = CategoriesData.getCategoryByTitle(
                            formation.categorie);

                        return Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: _buildFormationCard(
                            inscription,
                            formation,
                            progress,
                            category?.color ?? Colors.blue,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormationCard(
      inscription, formation, progress, Color color) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormationDetailsScreen(
              formation: formation,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: Image.asset(
                    formation.imageUrl,
                    width: 100,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 120,
                        color: Colors.grey[300],
                        child: Icon(Icons.image, color: Colors.grey),
                      );
                    },
                  ),
                ),
                // Contenu
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            formation.categorie,
                            style: TextStyle(
                              fontSize: 10,
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          formation.titre,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6),
                        // Badge de statut (En attente ou En cours)
                        if (inscription.statut == "En attente")
                          Text(
                            "⏳ En attente",
                            style: TextStyle(color: Colors.orange, fontSize: 12),
                          )
                        else if (progress != null && progress.isCompleted)
                          Text(
                            "✅ Terminé",
                            style: TextStyle(color: Colors.green, fontSize: 12),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Barre de progression (uniquement si validé et pas terminé)
            if (progress != null) ...[
              Divider(height: 1),
              Padding(
                padding: EdgeInsets.all(12),
                child: LinearProgressIndicator(
                  value: progress.progressPercentage,
                  backgroundColor: Colors.grey[200],
                  color: progress.isCompleted ? Colors.green : color,
                  minHeight: 6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school_outlined, size: 80, color: Colors.grey[300]),
          SizedBox(height: 20),
          Text(
            "Aucune formation trouvée",
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}