import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  // Light Theme Colors
  static const lightColors = {
    'background': Color(0xFFF8F9FE),
    'card': Colors.white,
    'primary': Color(0xFF6C5CE7),
    'secondary': Color(0xFFA8A5E6),
    'text': Color(0xFF2D3436),
    'subtext': Color(0xFF636E72),
    'calories': Color(0xFFFF6B6B),
    'protein': Color(0xFF32D39D),
    'carbs': Color(0xFF4ECFFF),
    'shadow': Color(0xFFE5E9F2),
  };

  // Dark Theme Colors
  static const darkColors = {
    'background': Color(0xFF1A1B1E),
    'card': Color(0xFF2D2F34),
    'primary': Color(0xFF8B80FF),
    'secondary': Color(0xFF6C5CE7),
    'text': Color(0xFFF5F6F7),
    'subtext': Color(0xFFADB5BD),
    'calories': Color(0xFFFF8787),
    'protein': Color(0xFF69DB7C),
    'carbs': Color(0xFF74C0FC),
    'shadow': Color(0xFF000000),
  };

  Map<String, Color> get colors => _isDarkMode ? darkColors : lightColors;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
} 