class MealCategory {
  final String id;
  final String name;
  final String thumb;
  final String description;

  MealCategory({
    required this.id,
    required this.name,
    required this.thumb,
    required this.description,
  });

  factory MealCategory.fromJson(Map<String, dynamic> j) {
    return MealCategory(
      id: j['idCategory'] ?? '',
      name: j['strCategory'] ?? '',
      thumb: j['strCategoryThumb'] ?? '',
      description: j['strCategoryDescription'] ?? '',
    );
  }
}
