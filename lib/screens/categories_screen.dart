import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/api_service.dart';
import '../widgets/category_card.dart';
import 'meals_by_category_screen.dart';
import 'meal_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ApiService _api = ApiService();

  List<MealCategory> _all = [];
  List<MealCategory> _filtered = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final cats = await _api.getCategories();
      setState(() {
        _all = cats;
        _filtered = cats;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Грешка при вчитување категории')),
      );
    }
  }

  void _search(String query) {
    if (query.isEmpty) {
      setState(() => _filtered = _all);
    } else {
      setState(() {
        _filtered = _all
            .where(
              (c) => c.name.toLowerCase().contains(query.toLowerCase()),
        )
            .toList();
      });
    }
  }

  Future<void> _openRandomMeal() async {
    try {
      final detail = await _api.getRandomMeal();
      if (!mounted || detail == null) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MealDetailScreen(mealId: detail.id),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Грешка при вчитување рандом рецепт')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),

      appBar: AppBar(
        title: const Text('Категории на јадења'),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8D6E63),
        onPressed: _openRandomMeal,
        child: const Icon(Icons.casino, color: Colors.white),
      ),

      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _filtered.isEmpty
          ? const Center(
        child: Text(
          'Нема категории (провери интернет или API)',
          style: TextStyle(fontSize: 16),
        ),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF5D4037),
                ),
                hintText: 'Пребарај категории...',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFF8D6E63),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFF5D4037),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final c = _filtered[index];
                return CategoryCard(
                  category: c,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MealsByCategoryScreen(
                          category: c.name,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
