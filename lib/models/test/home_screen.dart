// /*
//  * Copyright (c) 2021 Razeware LLC
//  *
//  * Permission is hereby granted, free of charge, to any person obtaining a copy
//  * of this software and associated documentation files (the "Software"), to deal
//  * in the Software without restriction, including without limitation the rights
//  * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  * copies of the Software, and to permit persons to whom the Software is
//  * furnished to do so, subject to the following conditions:
//  *
//  * The above copyright notice and this permission notice shall be included in
//  * all copies or substantial portions of the Software.
//  *
//  * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
//  * distribute, sublicense, create a derivative work, and/or sell copies of the
//  * Software in any work that is designed, intended, or marketed for pedagogical or
//  * instructional purposes related to programming, coding, application development,
//  * or information technology.  Permission for such use, copying, modification,
//  * merger, publication, distribution, sublicensing, creation of derivative works,
//  * or sale is expressly withheld.
//  *
//  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  * THE SOFTWARE.
//  */
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:new_flutter/models/grocery_manager.dart';
// import 'package:new_flutter/screens/explore_screen.dart';
// import 'package:new_flutter/screens/grocery_screen.dart';
// import 'package:new_flutter/screens/recipes_screen.dart';

// class HomeScreenTest extends StatefulWidget {
//   final int index;

//   HomeScreenTest({required String tab, Key? key})
//       : index = indexFrom(tab),
//         super(key: key);

//   @override
//   State<HomeScreenTest> createState() => _HomeScreenTestState();

//   static int indexFrom(String tab) {
//     switch (tab) {
//       case 'recipes':
//         return 1;
//       case 'tobuy':
//         return 2;
//       case 'explore':
//       default:
//         return 0;
//     }
//   }
// }

// class _HomeScreenTestState extends State<HomeScreenTest> {
//   late  GroceryManager groceryManager;
//   late int _selectedIndex;

//   @override
//   void initState() {
//     super.initState();
//     _selectedIndex = widget.index;
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _selectedIndex = widget.index;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.lightBlue,
//         title: const Text(
//           'Navigator',
//           style: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Explore'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.shopping_cart), label: 'Recipes'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tobuy'),
//         ],
//         backgroundColor: Colors.blue,
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.white,
//         onTap: (index) {
//           setState(
//             () {
//               _selectedIndex = index;
//               switch (index) {
//                 case 0:
//                   context.go('/home/explore');
//                   break;
//                 case 1:
//                   context.go('/home/recipes');
//                   break;
//                 case 2:
//                   context.go('/home/tobuy');
//                   break;
//               }
//             },
//           );
//         },
//       ),
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: [const ExploreScreen(), RecipeScreen(),  GrocerScreen(grocermanager: groceryManager,)],
//       ),
//     );
//   }
// }
