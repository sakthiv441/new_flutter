import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:new_flutter/screens/explore_screen.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../models/app_state_manager.dart';
import '../models/profile_manager.dart';
import '../models/user.dart';
import 'grocery_screen.dart';
import 'recipes_screen.dart';

class HomeScreen extends StatefulWidget {
  final int index;
  HomeScreen({
    Key? key,
    required String tab,
  })  : index = indexFrom(tab),
        super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  static int indexFrom(String tab) {
    switch (tab) {
      case 'recipes':
        return 1;
      case 'tobuy':
        return 2;
      case 'explore':
      default:
        return 0;
    }
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late int currenttab;
  @override
  void initState() {
    super.initState();
    currenttab = widget.index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currenttab = widget.index;
  }

  static List<Widget> pages = [
    const ExploreScreen(),
    RecipeScreen(),
    const GrocerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (context, appStatemanager, child) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                child: Container(),
              ),
            ),
            title: Text(
              'My Recipe App',
              style: Theme.of(context).textTheme.headline6,
            ),
            centerTitle: true,
            actions: [profileButton()],
          ),
          body: IndexedStack(
            index: currenttab,
            children: pages,
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color(0X4d000000),
                offset: Offset(0, -0.1),
              ),
            ]),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                child: BottomNavigationBar(
                  selectedItemColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  currentIndex: currenttab,
                  elevation: 0,
                  onTap: (int index) {
                    setState(
                      () {
                        currenttab = index;
                        switch (index) {
                          case 0:
                            context.go('/home/explore');
                            break;
                          case 1:
                            context.go('/home/recipes');
                            break;
                          case 2:
                            context.go('/home/tobuy');
                            break;
                        }
                      },
                    );
                  },
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.explore),
                      label: 'Explore',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.book),
                      label: 'Recipes',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      label: 'To Buy',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget profileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/profile_pics/person_stef.jpeg',
          ),
        ),
        onTap: () {
          context.push('/profilescreen');
        },
      ),
    );
  }
}
