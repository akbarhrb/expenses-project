import 'package:flutter/material.dart';
import 'expense.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

List<Expense> expenses = Expense.expenses;
String baseUrl = "flutterapp1.atwebpages.com";

class ECategory {
  IconData? iconData;
  String? catName;
  double? total;

  ECategory(
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

  static List<ECategory> categories = [];

  // Map for icon name to IconData
  static Map<String, IconData> iconMapping = {
    'home': Icons.home,
    'shopping': Icons.shopping_cart,
    'travel': Icons.airplanemode_active,
    'gift': Icons.card_giftcard,
    'education': Icons.school,
    'clothes': Icons.checkroom,
    'healthcare': Icons.local_hospital,
    'groceries': Icons.local_grocery_store,
    // Add more mappings as needed
  };

  static Future<ECategory> getCat() async {
    try {
      final url = Uri.http(baseUrl, 'getCat.php');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        categories.clear();
        for (var row in jsonResponse) {
          String iconName = row['iconData'];
          IconData? icon = iconMapping[iconName.toLowerCase()];
          icon = icon ?? Icons.error;

          ECategory cat = ECategory(
              catName: row['cName'],
              iconData: icon,
              total: double.parse(row['total']));
          categories.add(cat);
        }
        return categories[0];
      } else {
        // Handle the error (e.g., show a default error category)
        ECategory cat =
            ECategory(catName: 'Error', iconData: Icons.error, total: 0.0);
        categories.add(cat);
        return cat;
      }
    } catch (e) {
      print(e.toString());
      return categories[0];
    }
  }
}
