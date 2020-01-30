import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {

  String categorySelected = "todos";

  void updateCategoryId(String categorySelected) {
    this.categorySelected  = categorySelected;
    notifyListeners();
  }
}