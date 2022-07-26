import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/grocery_tile.dart';
import '../models/grocery_manager.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({Key? key, required this.manager}) : super(key: key);
  final GroceryManager manager;
  @override
  Widget build(BuildContext context) {
    return Consumer<GroceryManager>(builder: (context, manager, child) {
      final groceryItems = manager.groceryItems;

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
            itemBuilder: ((context, index) {
              final item = groceryItems[index];
              return Dismissible(
                key: Key(item.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                onDismissed: (direction) {
                  manager.deleteItem(index);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${item.name} dismissed'),
                  ));
                },
                child: InkWell(
                  child: GroceryTile(
                    item: item,
                    key: Key(item.id),
                    onComplete: (change) {
                      if (change != null) {
                        manager.completeItem(index, change);
                      }
                    },
                  ),
                  onTap: () {
                    GoRouter.of(context).goNamed(
                      'groceryitemupdate',
                      params: {'tab': 'tobuy', 'id': 'Name ${item.name}'},
                    );
                  },
                ),
              );
            }),
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemCount: groceryItems.length),
      );
    });
  }
}
