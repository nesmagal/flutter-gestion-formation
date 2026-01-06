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

class _MesFormationsScreenState extends State<MesFormationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inscriptions = InscriptionsService.getUserInscriptions();
    
    // FIX: Utiliser parenthèses () au lieu d'accolades {}
    final enCours = inscriptions.where((i) {
      final progress = ProgressService.getProgress(i.formationTitre);
      return progress != null && !progress.isCompleted;
    }).toList();
    
    final terminees = inscriptions.where((i) {
      final progress = ProgressService.getProgress(i.formationTitre);
      return progress != null && progress.isCompleted;
    }).toList();
    
    final enAttente = inscriptions.where((i) => i.statut == "En attente").toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
              padding: EdgeInsets.all(24),
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
                    "${inscriptions.length} formation${inscriptions.length > 1 ? 's' : ''}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Tabs
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelColor: Color(0xFF2196F3),
                      unselectedLabelColor: Colors.white,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      tabs: [
                        Tab(text: "En cours (${enCours.length})"),
                        Tab(text: "Terminées (${terminees.length})"),
                        Tab(text: "En attente (${enAttente.length})"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Content avec TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // En cours
                  _buildFormationsList(enCours, "en_cours"),
                  // Terminées
                  _buildFormationsList(terminees, "terminees"),
                  // En attente
                  _buildFormationsList(enAttente, "en_attente"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormationsList(List inscriptions, String type) {
    if (inscriptions.isEmpty) {
      return _buildEmptyState(type);
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: inscriptions.length,
      itemBuilder: (context, index) {
        final inscription = inscriptions[index];
        final formation = FormationsData.formations.firstWhere(
          (f) => f.titre == inscription.formationTitre,
          orElse: () => FormationsData.formations[0],
        );
        final progress = ProgressService.getProgress(inscription.formationTitre);
        final category = CategoriesData.getCategoryByTitle(formation.categorie);

        return Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: _buildFormationCard(
            inscription,
            formation,
            progress,
            category?.color ?? Colors.blue,
            type,
          ),
        );
      },
    );
  }

  Widget _buildFormationCard(inscription, formation, progress, Color color, String type) {
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
            // Section supérieure avec image et infos
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
                        // Badge catégorie
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

                        // Titre
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

                        // Formateur
                        Row(
                          children: [
                            Icon(Icons.person, size: 14, color: Colors.grey[600]),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                formation.nomFormateur,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        if (type == "en_attente") ...[
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "⏳ ${inscription.statut}",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Barre de progression (si applicable)
            if (progress != null && type != "en_attente") ...[
              Divider(height: 1),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          progress.isCompleted
                              ? "✅ Formation terminée !"
                              : "Progression: ${(progress.progressPercentage * 100).toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: progress.isCompleted ? Colors.green : color,
                          ),
                        ),
                        if (!progress.isCompleted)
                          Text(
                            "${progress.completedLessons}/${progress.totalLessons} leçons",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress.progressPercentage,
                        backgroundColor: Colors.grey[200],
                        color: progress.isCompleted ? Colors.green : color,
                        minHeight: 8,
                      ),
                    ),
                    if (!progress.isCompleted) ...[
                      SizedBox(height: 8),
                      Text(
                        "Leçon actuelle: ${progress.currentLesson}",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String type) {
    String message;
    IconData icon;
    
    switch (type) {
      case "en_cours":
        message = "Aucune formation en cours";
        icon = Icons.play_circle_outline;
        break;
      case "terminees":
        message = "Aucune formation terminée";
        icon = Icons.check_circle_outline;
        break;
      case "en_attente":
        message = "Aucune inscription en attente";
        icon = Icons.hourglass_empty;
        break;
      default:
        message = "Aucune formation";
        icon = Icons.school_outlined;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.grey[300],
          ),
          SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Explorez les formations disponibles",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}