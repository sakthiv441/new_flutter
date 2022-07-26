import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/app_state_manager.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 30, left: 30, right: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.asset('assets/foodlist_assets/empty_list.png'),
            )),
            const Text(
              'No Groceries',
              style: TextStyle(fontSize: 21.0),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              'shopping for ingredients?\n'
              'Tap the + button to write them down!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            MaterialButton(
              textColor: Colors.white,
              onPressed: () {
                context.goNamed('homeroute', params: {'tab': 'recipes'});
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.green,
              child: const Text('Browse Recipes'),
            ),
          ],
        ),
      ),
    );
  }
}
