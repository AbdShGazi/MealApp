import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../models/meal.dart';
import '../providers/meals_provider.dart';
import '../providers/theme_provider.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback? onTap;

  const MealCard({
    super.key,
    required this.meal,
    this.onTap,
  });

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Meal'),
        content: const Text('Are you sure you want to delete this meal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<MealsProvider>().removeMeal(meal.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Meal deleted'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () => context.read<MealsProvider>().restoreMeal(meal),
                  ),
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _ActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color? color,
    bool isActive = false,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Icon(
            icon,
            size: 18,
            color: isActive ? Colors.red : color ?? Colors.grey[600],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image Stack
                      Stack(
                        children: [
                          // Image
                          Container(
                            height: 120, // Reduced from 140
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  meal.imageUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Gradient
                          Container(
                            height: 120, // Match image height
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                          // Action Buttons
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Row(
                              children: [
                                _ActionButton(
                                  icon: Icons.delete_outline,
                                  color: Colors.red[400],
                                  onPressed: () => _showDeleteDialog(context),
                                ),
                                const SizedBox(width: 4), // Reduced from 8
                                Consumer<MealsProvider>(
                                  builder: (context, provider, _) => _ActionButton(
                                    icon: provider.isFavorite(meal) 
                                        ? Icons.favorite_rounded 
                                        : Icons.favorite_outline_rounded,
                                    onPressed: () {
                                      provider.toggleFavorite(meal);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            provider.isFavorite(meal) 
                                                ? 'Added to favorites' 
                                                : 'Removed from favorites'
                                          ),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                    color: Colors.red[400],
                                    isActive: provider.isFavorite(meal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Title
                          Positioned(
                            bottom: 8,
                            left: 8,
                            right: 8,
                            child: Text(
                              meal.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16, // Reduced from 18
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 8,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      // Stats Row
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6, // Reduced from 12
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStat(
                              context,
                              Icons.star_rounded,
                              '${meal.rating}',
                              'Rating',
                              Colors.amber,
                            ),
                            _buildDivider(),
                            _buildStat(
                              context,
                              Icons.schedule_rounded,
                              meal.cookingTime.toString(),
                              'Time',
                              Colors.blue,
                            ),
                            _buildDivider(),
                            _buildStat(
                              context,
                              Icons.local_fire_department_rounded,
                              '350',
                              'Cal',
                              Colors.orange,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18), // Reduced from 20
        const SizedBox(height: 1), // Reduced from 2
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13, // Reduced from 14
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontSize: 11, // Reduced from 12
              ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 20, // Reduced from 24
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: 200,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / 
                    loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            color: Colors.grey[300],
            child: const Icon(Icons.error),
          );
        },
      );
    } else if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        height: 200,
      );
    } else {
      return Image.file(
        File(imageUrl),
        fit: BoxFit.cover,
        height: 200,
      );
    }
  }
}