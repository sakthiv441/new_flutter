import 'package:flutter/material.dart';
import '../models/explore_recipe.dart';
import 'card1.dart';
import 'card2.dart';
import 'card3.dart';

class TodayRecipeListView extends StatelessWidget {
  const TodayRecipeListView({Key? key, required this.recipes})
      : super(key: key);
  final List<ExploreRecipe> recipes;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
        child: Text(
          'Recipes of the Day',
          style: Theme.of(
            context,
          ).textTheme.headline1,
        ),
      ),
      const SizedBox(
        height: 16,
      ),
      Container(
        height: 400,
        color: Colors.transparent,
        child: ListView.separated(
            padding: const EdgeInsets.all(16),
            scrollDirection: Axis.horizontal,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return buildCard(recipe);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 16,
              );
            }),
      ),
    ]);
  }
}

Widget buildCard(ExploreRecipe recipe) {
  if (recipe.cardType == RecipeCardType.card1) {
    return Card1(recipe: recipe);
  } else if (recipe.cardType == RecipeCardType.card2) {
    return Card2(recipe: recipe);
  } else if (recipe.cardType == RecipeCardType.card3) {
    return Card3(recipe: recipe);
  } else {
    throw Exception('this Card doesnt exist yet');
  }
}
