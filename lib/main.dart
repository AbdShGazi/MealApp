import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'package:provider/provider.dart';
import 'providers/meals_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MealsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Meal App',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: themeProvider.colors['primary']!,
              brightness: themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            scaffoldBackgroundColor: themeProvider.colors['background'],
          ),
          home: const HomePage(),
        );
      },
    );
  }
}

class AnimatedNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const AnimatedNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        if (index == 3) {
          showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Meal'),
              content: const Text('Are you sure you want to delete this meal?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                    onDestinationSelected(index);
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
          );
        } else {
          onDestinationSelected(index);
        }
      },
      animationDuration: const Duration(milliseconds: 400),
      destinations: [
        _buildNavDestination(
          icon: Icons.restaurant_menu,
          label: 'Meals',
          index: 0,
        ),
        _buildNavDestination(
          icon: Icons.favorite,
          label: 'Favorites',
          index: 1,
        ),
        _buildNavDestination(
          icon: Icons.add_circle_outline,
          selectedIcon: Icons.add_circle,
          label: 'Add Meal',
          index: 2,
        ),
        _buildNavDestination(
          icon: Icons.delete_outline,
          selectedIcon: Icons.delete,
          label: 'Delete',
          index: 3,
        ),
        _buildNavDestination(
          icon: Icons.person_outline,
          selectedIcon: Icons.person,
          label: 'Profile',
          index: 4,
        ),
      ],
    );
  }

  Widget _buildNavDestination({
    required IconData icon,
    IconData? selectedIcon,
    required String label,
    required int index,
  }) {
    return NavigationDestination(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: Icon(
          selectedIndex == index ? (selectedIcon ?? icon) : icon,
          key: ValueKey<bool>(selectedIndex == index),
        ),
      ),
      label: label,
    );
  }
}
