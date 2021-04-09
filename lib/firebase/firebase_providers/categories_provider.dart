import 'package:flutter/cupertino.dart';
import 'package:my_wallet/firebase/firestore/category_fdb.dart';
import 'package:my_wallet/firebase/models/category.dart';

class CategoryProvider extends ChangeNotifier{
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  List<Category> setCategories(List<Category> categories) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _categories = categories;
      notifyListeners();
    });
  }

  void addCategory(Category category) {
    CategoryFDB.createCategory(category);
    categories.add(category);
  }

  void removeCategory(Category category) {
    CategoryFDB.deleteCategory(category);
    categories.remove(category);
  }

  void updateCategory({Category category, String name, int iconValue}) {
    category.name = name;
    category.iconValue = iconValue;
    CategoryFDB.updateCategory(category);
  }
}