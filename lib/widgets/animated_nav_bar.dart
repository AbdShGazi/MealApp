import 'package:flutter/material.dart';

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
      onDestinationSelected: onDestinationSelected,
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
          icon: Icons.person_outline,
          selectedIcon: Icons.person,
          label: 'Profile',
          index: 3,
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