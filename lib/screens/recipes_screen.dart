import 'package:flutter/material.dart';

import 'package:new_flutter/api/mock_fooderlich_service.dart';
import 'package:new_flutter/components/components.dart';

import '../models/simple_recipe.dart';

class RecipeScreen extends StatelessWidget {
  RecipeScreen({Key? key}) : super(key: key);
  final exploreservice = MockFooderlichService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: exploreservice.getRecipes(),
      builder:
          (BuildContext context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final recipeGrid = snapshot.data ?? [];
          return RecipesGridView(recipes: recipeGrid);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
