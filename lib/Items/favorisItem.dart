import 'package:flutter/material.dart';
import '../models/formationModel.dart';
import '../services/favoritesService.dart';

class FavoriteButton extends StatefulWidget {
  final FormationModel formation;
  final double size;
  final bool showBackground;

  const FavoriteButton({
    Key? key,
    required this.formation,
    this.size = 24,
    this.showBackground = false,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    // Animation
    _controller.forward().then((_) {
      _controller.reverse();
    });

    setState(() {
      FavoritesService.toggleFavorite(widget.formation);
    });

    // Feedback utilisateur
    final isFavorite = FavoritesService.isFavorite(widget.formation.titre);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? "✅ Ajouté aux favoris"
              : "❌ Retiré des favoris",
        ),
        duration: Duration(seconds: 2),
        backgroundColor: isFavorite ? Colors.green : Colors.grey[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = FavoritesService.isFavorite(widget.formation.titre);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.showBackground
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey[600],
                  size: widget.size,
                ),
                onPressed: _toggleFavorite,
              ),
            )
          : IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey[600],
                size: widget.size,
              ),
              onPressed: _toggleFavorite,
            ),
    );
  }
}