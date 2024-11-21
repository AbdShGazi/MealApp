class Meal {
  final String id;
  final String name;
  final int cookingTime;
  final int calories;
  final String imageUrl;
  final double rating;

  bool isFavorite;

  Meal({
    required this.id,
    required this.name,
    required this.cookingTime,
    required this.calories,
    required this.imageUrl,
    this.rating = 0.0,
    
    this.isFavorite = false,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      cookingTime: json['cookingTime'] ?? 0,
      calories: json['calories'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      rating: json['rating'] ?? 0.0,
      isFavorite: json['isFavorite'] ?? false,
    );
  }
} 