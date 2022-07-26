import 'package:flutter/material.dart';

import 'grocery_item.dart';

class GroceryManager extends ChangeNotifier {
  final _groceryItems = <GroceryItem>[];

  bool _createNewItem = false;
  int _selectedIndex = -1;
  List<GroceryItem> get groceryItems => _groceryItems;
  bool get isCreateNewItem => _createNewItem;
  GroceryItem? get selectedGroceryItem {
    if (_groceryItems.length > _selectedIndex) {
      _groceryItems[_selectedIndex]; // You can safely access the element here.
    }
    return null;
  }

  int get selectedIndex => _selectedIndex;

  void createNewItem() {
    _createNewItem = true;
    notifyListeners();
  }

  void update(String id) {
    final val = groceryItems.indexWhere((element) => element.id == id);
    _groceryItems[val];
  }

  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    notifyListeners();
  }

  setSelectedGroceryItem(String id) {
    final index = groceryItems.indexWhere((element) => element.id == id);
    _selectedIndex = index;
    notifyListeners();
  }

  void updateItem(
    GroceryItem item,
    int index,
  ) {
    _groceryItems[index] = item;
    notifyListeners();
  }

  void groceryItemTapped(int index) {
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }

  GroceryItem family(String fid) => groceryItems.family(fid);
}

extension on List<GroceryItem> {
  GroceryItem family(String fid) => singleWhere(
        (f) => f.id == fid,
        orElse: () => throw Exception('unknown family $fid'),
      );
}
