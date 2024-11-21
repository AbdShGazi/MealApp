import 'package:flutter/foundation.dart';
import '../models/meal.dart';

class MealsProvider extends ChangeNotifier {
  final List<Meal> _meals = [
    Meal(
      id: '1',
      name: 'Cheese Burger',
      cookingTime: 30,
      calories: 800,
      imageUrl: 'https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg',
    ),
    Meal(
      id: '2',
      name: 'Grilled Chicken',
      cookingTime: 45,
      calories: 450,
      imageUrl: 'https://media.cnn.com/api/v1/images/stellar/prod/140430115517-06-comfort-foods.jpg?q=w_1110,c_fill',
    ),
    // ... other meals
  ];

  List<Meal> get meals => [..._meals];
  List<Meal> get favorites => _meals.where((meal) => meal.isFavorite).toList();

  void addTestMeals() {
    if (_meals.isEmpty) {
      for (var i = 0; i < 10; i++) {
        addMeal(
          Meal(
            id: 'meal_$i',
            name: 'Delicious Meal $i',
            rating: 4.5,
            imageUrl: 'https://picsum.photos/200',
            calories: 350 + i * 50,
            isFavorite: false,
            cookingTime: 30,
          ),
        );
      }
    }
  }

  void addMeal(Meal meal) {
    _meals.add(meal);
    notifyListeners();
  }

  void removeMeal(String id) {
    final index = _meals.indexWhere((meal) => meal.id == id);
    if (index >= 0) {
      _meals.removeAt(index);
      notifyListeners();
    }
  }

  void restoreMeal(Meal meal) {
    final index = _meals.indexWhere((m) => m.id == meal.id);
    if (index >= 0) {
      _meals.insert(index, meal);
      notifyListeners();
    }
  }

  void toggleFavorite(Meal meal) {
    final index = _meals.indexWhere((m) => m.id == meal.id);
    if (index >= 0) {
      _meals[index].isFavorite = !_meals[index].isFavorite;
      notifyListeners();
    }
  }

  bool isFavorite(Meal meal) {
    return _meals.any((m) => m.id == meal.id && m.isFavorite);
  }
} 