import 'package:flutter/material.dart';
import '../models/simple_recipe.dart';
import 'recipe_thumbnail.dart';

class RecipesGridView extends StatelessWidget {
  const RecipesGridView({Key? key, required this.recipes}) : super(key: key);
  final List<SimpleRecipe> recipes;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: GridView.builder(
        itemCount: recipes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final simpleRecipe = recipes[index];
          return RecipeThumbnail(
            recipe: simpleRecipe,
          );
        },
      ),
    );
  }
}
