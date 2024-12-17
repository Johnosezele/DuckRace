import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UpdateCategory {
  preRace('Pre-Race'),
  race('Race'),
  postRace('Post-Race');

  final String label;
  const UpdateCategory(this.label);
}

final selectedCategoryProvider = StateProvider<UpdateCategory>((ref) {
  return UpdateCategory.preRace;
});

class CategorySelector extends ConsumerWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: UpdateCategory.values.map((category) {
          final isSelected = category == selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(category.label),
              onSelected: (_) {
                ref.read(selectedCategoryProvider.notifier).state = category;
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
