import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_flutter/screens/grocery_list_screen.dart';
import 'package:provider/provider.dart';

import '../models/grocery_manager.dart';
import 'empty_grocer_screen.dart';

class GrocerScreen extends StatelessWidget {
  const GrocerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 60, top: 8),
        child: FloatingActionButton(
          onPressed: () {
            context.goNamed('groceryitemadd', params: {'tab': 'tobuy'});
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: buildGroceryScreen(),
    );
  }
}

Widget buildGroceryScreen() {
  return Consumer<GroceryManager>(
    builder: (context, manager, child) {
      if (manager.groceryItems.isNotEmpty) {
        return GroceryListScreen(manager: manager);
      } else {
        return const EmptyGroceryScreen();
      }
    },
  );
}
