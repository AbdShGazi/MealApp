import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../delegates/meal_search_delegate.dart';
import '../widgets/meal_card.dart';
import '../providers/meals_provider.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MealsProvider>(
      builder: (context, mealsProvider, child) {
        final meals = mealsProvider.meals;

        // Add test meals if the list is empty
        if (meals.isEmpty) {
          mealsProvider.addTestMeals();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Discover Meals'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MealSearchDelegate(),
                  );
                },
              ),
            ],
          ),
          body: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return MealCard(
                meal: meal,
                onTap: () {
                  // TODO: Navigate to meal details
                },
              );
            },
          ),
        );
      },
    );
  }
} 