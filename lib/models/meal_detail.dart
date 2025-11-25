class MealDetail {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumb;
  final String youtube;
  final List<Map<String, String>> ingredients;

  MealDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumb,
    required this.youtube,
    required this.ingredients,
  });

  factory MealDetail.fromJson(Map<String, dynamic> j) {
    final List<Map<String, String>> ing = [];
    for (int i = 1; i <= 20; i++) {
      final ingName = (j['strIngredient$i'] ?? '').toString().trim();
      final measure = (j['strMeasure$i'] ?? '').toString().trim();
      if (ingName.isNotEmpty) {
        ing.add({'ingredient': ingName, 'measure': measure});
      }
    }

    return MealDetail(
      id: j['idMeal'] ?? '',
      name: j['strMeal'] ?? '',
      category: j['strCategory'] ?? '',
      area: j['strArea'] ?? '',
      instructions: j['strInstructions'] ?? '',
      thumb: j['strMealThumb'] ?? '',
      youtube: j['strYoutube'] ?? '',
      ingredients: ing,
    );
  }
}
