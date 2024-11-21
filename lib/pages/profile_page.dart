import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/meals_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final colors = themeProvider.colors;
    final mealsProvider = context.watch<MealsProvider>();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 32),
          // Profile Image
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: colors['primary']!.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: colors['primary'],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colors['primary'],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: colors['card'],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // User Name
          Text(
            'User Name',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colors['text'],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'user@email.com',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors['subtext'],
            ),
          ),
          const SizedBox(height: 32),

          // Stats Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard(
                context: context,
                icon: Icons.restaurant_menu,
                label: 'My Meals',
                value: mealsProvider.meals.length.toString(),
              ),
              _buildStatCard(
                context: context,
                icon: Icons.favorite,
                label: 'Favorites',
                value: mealsProvider.favorites.length.toString(),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Settings Options
          _buildSettingsTile(
            context: context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () {},
          ),
          _buildSettingsTile(
            context: context,
            icon: Icons.lock_outline,
            title: 'Privacy',
            onTap: () {},
          ),
          _buildSettingsTile(
            context: context,
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          
          // Logout Button
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement logout
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors['calories'],
              foregroundColor: colors['card'],
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    final colors = context.read<ThemeProvider>().colors;
    
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors['card'],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors['shadow']!.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: colors['primary']),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colors['text'],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: colors['subtext'],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final colors = context.read<ThemeProvider>().colors;
    
    return ListTile(
      leading: Icon(icon, color: colors['primary']),
      title: Text(title),
      onTap: onTap,
    );
  }
} 