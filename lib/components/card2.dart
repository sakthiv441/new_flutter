import 'package:flutter/material.dart';

import '../fooderlich_theme.dart';
import '../models/models.dart';
import 'Author_card.dart';

class Card2 extends StatelessWidget {
  const Card2({Key? key, required this.recipe}) : super(key: key);
  final ExploreRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                recipe.backgroundImage,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(
              16.0,
            ))),
        child: Column(children: [
          AuthorCard(
            authorName: recipe.authorName,
            title: recipe.role,
            imageProvider: AssetImage(recipe.profileImage),
          ),
          Expanded(
            child: Stack(children: [
              Positioned(
                bottom: 16,
                right: 16,
                child: Text(
                  recipe.title,
                  style: FooderlichTheme.lightTextTheme.headline1,
                ),
              ),
              Positioned(
                bottom: 70,
                left: 16,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    recipe.subtitle,
                    style: FooderlichTheme.lightTextTheme.headline1,
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
