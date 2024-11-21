import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../delegates/meal_search_delegate.dart';
import '../widgets/theme_toggle_button.dart';
import '../pages/meals_page.dart';
import '../pages/favorites_page.dart';
import '../pages/add_meal_page.dart';
import '../pages/profile_page.dart';
import '../providers/meals_provider.dart';
import '../widgets/meal_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    MealsGrid(),
    FavoritesPage(),
    AddMealPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final colors = themeProvider.colors;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Discover Meals',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ThemeToggleButton(),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.search, size: 24),
            onPressed: () async {
              final result = await showSearch(
                context: context,
                delegate: MealSearchDelegate(),
              );
              if (result != null) {
                // Handle the selected meal
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: colors['shadow']!.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          height: 65,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: colors['card'],
          indicatorColor: colors['primary']!.withOpacity(0.1),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.restaurant_menu_outlined, 
                color: colors['subtext'],
              ),
              selectedIcon: Icon(Icons.restaurant_menu_rounded, 
                color: colors['primary'],
              ),
              label: 'Meals',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline_rounded, 
                color: colors['subtext'],
              ),
              selectedIcon: Icon(Icons.favorite_rounded, 
                color: colors['primary'],
              ),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_circle_outline_rounded, 
                color: colors['subtext'],
              ),
              selectedIcon: Icon(Icons.add_circle_rounded, 
                color: colors['primary'],
              ),
              label: 'Add Meal',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded, 
                color: colors['subtext'],
              ),
              selectedIcon: Icon(Icons.person_rounded, 
                color: colors['primary'],
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class MealsGrid extends StatelessWidget {
  const MealsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MealsProvider>(
      builder: (context, mealsProvider, child) {
        final meals = mealsProvider.meals;

        if (meals.isEmpty) {
          mealsProvider.addTestMeals();
        }

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: meals.length,
          itemBuilder: (context, index) {
            final meal = meals[index];
            return MealCard(
              meal: meal,
              onTap: () {
                // Handle meal tap
              },
            );
          },
        );
      },
    );
  }
} 