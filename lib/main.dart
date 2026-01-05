import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gestion_formations_flutter/Splashscreen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestionnaire de Formations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(       
         primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // ✅ Splash au démarrage
    );
  }
}
