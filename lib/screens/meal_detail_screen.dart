import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart'; // можеш да го избришеш ако веќе не го користиш

import '../models/meal_detail.dart';
import '../services/api_service.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;

  const MealDetailScreen({
    super.key,
    required this.mealId,
  });

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final ApiService _api = ApiService();

  MealDetail? _detail;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    try {
      final d = await _api.getMealDetail(widget.mealId);
      setState(() {
        _detail = d;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Грешка при вчитување детали')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        title: const Text('Детален рецепт'),
      ),
      body: _loading || _detail == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Слика
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: _detail!.thumb,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // Име
            Text(
              _detail!.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
            const SizedBox(height: 8),

            // Категорија и област
            Text('Категорија: ${_detail!.category}'),
            Text('Област: ${_detail!.area}'),
            const SizedBox(height: 16),

            // Состојки
            const Text(
              'Состојки:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5D4037),
              ),
            ),
            const SizedBox(height: 6),
            ..._detail!.ingredients.map(
                  (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text('• ${e['ingredient']} — ${e['measure']}'),
              ),
            ),

            const SizedBox(height: 16),

            // Инструкции
            const Text(
              'Инструкции:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5D4037),
              ),
            ),
            const SizedBox(height: 6),
            Text(_detail!.instructions),

            const SizedBox(height: 16),

            // YouTube линк (ако постои) – само го прикажуваме
            if (_detail!.youtube.isNotEmpty) ...[
              const Text(
                'YouTube линк:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5D4037),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: SelectableText(
                      _detail!.youtube,
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
