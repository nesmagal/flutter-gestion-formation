// lib/screens/inscriptionFormScreen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_formations_flutter/models/formationModel.dart';
import 'package:gestion_formations_flutter/models/inscriptionModel.dart';
import 'package:gestion_formations_flutter/services/inscriptionsService.dart';
import 'package:gestion_formations_flutter/services/progressService.dart';

class InscriptionFormScreen extends StatefulWidget {
  final FormationModel formation;

  const InscriptionFormScreen({
    Key? key,
    required this.formation,
  }) : super(key: key);

  @override
  _InscriptionFormScreenState createState() => _InscriptionFormScreenState();
}

class _InscriptionFormScreenState extends State<InscriptionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _motivationController = TextEditingController();
  
  String _niveauEtude = "Bac";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      _emailController.text = user.email!;
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _motivationController.dispose();
    super.dispose();
  }

  Future<void> _submitInscription() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      
      if (user == null) {
        throw Exception("Utilisateur non connecté");
      }

      // Créer l'inscription
      final inscription = InscriptionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: user.uid,
        formationId: widget.formation.titre,
        formationTitre: widget.formation.titre,
        nom: _nomController.text.trim(),
        prenom: _prenomController.text.trim(),
        email: _emailController.text.trim(),
        telephone: _telephoneController.text.trim(),
        niveauEtude: _niveauEtude,
        motivation: _motivationController.text.trim(),
        dateInscription: DateTime.now(),
      );

      // Enregistrer l'inscription
      InscriptionsService.addInscription(inscription);

      // Initialiser la progression pour cette formation
      ProgressService.initializeProgress(widget.formation.titre, 20);

      // Simulation de sauvegarde
      await Future.delayed(Duration(seconds: 2));
      
      print("=== INSCRIPTION ENREGISTRÉE ===");
      print(inscription.toMap());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("✅ Inscription enregistrée avec succès !"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("❌ Erreur: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Inscription",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF2196F3),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  Icon(Icons.school, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    widget.formation.titre,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${widget.formation.prix.toStringAsFixed(2)} TND",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Informations personnelles",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),

                    _buildTextField(
                      controller: _nomController,
                      label: "Nom",
                      icon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez entrer votre nom";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    _buildTextField(
                      controller: _prenomController,
                      label: "Prénom",
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez entrer votre prénom";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    _buildTextField(
                      controller: _emailController,
                      label: "Email",
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez entrer votre email";
                        }
                        if (!value.contains('@')) {
                          return "Email invalide";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    _buildTextField(
                      controller: _telephoneController,
                      label: "Téléphone",
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez entrer votre téléphone";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonFormField<String>(
                        value: _niveauEtude,
                        decoration: InputDecoration(
                          labelText: "Niveau d'étude",
                          prefixIcon: Icon(Icons.school, color: Color(0xFF2196F3)),
                          border: InputBorder.none,
                        ),
                        items: ["Bac", "Bac +2", "Bac +3", "Bac +5", "Autre"]
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _niveauEtude = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: TextFormField(
                        controller: _motivationController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: "Motivation",
                          hintText: "Pourquoi voulez-vous suivre cette formation?",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(bottom: 60),
                            child: Icon(Icons.edit, color: Color(0xFF2196F3)),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez décrire votre motivation";
                          }
                          if (value.length < 20) {
                            return "Minimum 20 caractères";
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitInscription,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2196F3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: _isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "CONFIRMER L'INSCRIPTION",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF2196F3)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
        validator: validator,
      ),
    );
  }
}