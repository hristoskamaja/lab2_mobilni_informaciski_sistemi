class Meal {
  final String id;
  final String name;
  final String thumb;

  Meal({
    required this.id,
    required this.name,
    required this.thumb,
  });

  factory Meal.fromJson(Map<String, dynamic> j) {
    return Meal(
      id: j['idMeal'] ?? '',
      name: j['strMeal'] ?? '',
      thumb: j['strMealThumb'] ?? '',
    );
  }
}
