import 'package:flutter/material.dart';
import 'expense.dart';

List<Expense> expenses = Expense.expenses;

class Category {
  IconData? iconData;
  String? catName;
  double? total;

  Category(
      {required this.catName, required this.iconData, required this.total});

  @override
  String toString() {
    return catName as String;
  }

  void calculateTotal(List<Expense> expenses) {
    total = expenses
        .where((expense) => expense.category?.catName == catName)
        .fold(0.0, (sum, expense) => sum! + (expense.amount ?? 0.0));
  }

  static List<Category> categories = [
    Category(catName: 'Home', iconData: Icons.house, total: 0.0),
    Category(
        catName: 'Shopping',
        iconData: Icons.local_grocery_store_outlined,
        total: 0.0),
    Category(
        catName: 'travel', iconData: Icons.airplanemode_active, total: 0.0),
    Category(catName: 'Gifts', iconData: Icons.card_giftcard_sharp, total: 0.0),
    Category(catName: 'Education', iconData: Icons.school, total: 0.0),
    Category(catName: 'Clothes', iconData: Icons.browse_gallery, total: 0.0),
    Category(
        catName: 'HealthCare', iconData: Icons.health_and_safety, total: 00.0),
    Category(
        catName: 'Groceries',
        iconData: Icons.local_grocery_store_outlined,
        total: 0.0),
  ];
}
