import 'dart:convert';

import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_detail.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<MealCategory>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['categories'] ?? [];
      return list.map((e) => MealCategory.fromJson(e)).toList();
    } else {
      throw Exception('Не може да се вчитаат категории');
    }
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    final response =
    await http.get(Uri.parse('$baseUrl/filter.php?c=$category'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['meals'] ?? [];
      return list.map((e) => Meal.fromJson(e)).toList();
    } else {
      throw Exception('Не може да се вчитаат јадења');
    }
  }

  Future<MealDetail?> getMealDetail(String id) async {
    final response =
    await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['meals'] ?? [];
      if (list.isEmpty) return null;
      return MealDetail.fromJson(list.first);
    } else {
      throw Exception('Не може да се вчитаат детали');
    }
  }

  Future<MealDetail?> getRandomMeal() async {
    final response =
    await http.get(Uri.parse('$baseUrl/random.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['meals'] ?? [];
      if (list.isEmpty) return null;
      return MealDetail.fromJson(list.first);
    } else {
      throw Exception('Не може да се вчита рандом рецепт');
    }
  }
}
