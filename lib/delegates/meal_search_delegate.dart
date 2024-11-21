import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meals_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/meal_card.dart';

class MealSearchDelegate extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    final colors = themeProvider.colors;
    
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: colors['background'],
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: colors['subtext']),
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
        titleLarge: TextStyle(color: colors['text']),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final mealsProvider = context.watch<MealsProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final colors = themeProvider.colors;

    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 100,
              color: colors['subtext']!.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Start typing to search meals',
              style: TextStyle(
                color: colors['subtext'],
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    final searchResults = mealsProvider.meals.where((meal) {
      return meal.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.no_meals,
              size: 100,
              color: colors['subtext']!.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No meals found',
              style: TextStyle(
                color: colors['subtext'],
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      color: colors['background'],
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final meal = searchResults[index];
          return MealCard(
            meal: meal,
            onTap: () {
              close(context, meal.id);
              // You can also navigate to meal details here if needed
            },
          );
        },
      ),
    );
  }
} 