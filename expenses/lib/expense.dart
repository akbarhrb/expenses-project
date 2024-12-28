// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'ECategory.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Expense {
  ECategory? category;
  String? name;
  double? amount;
  String? month;
  DateTime? createdAt;

  final Map<int, String> idCat = {
    1: 'Home',
    2: 'Shopping',
    3: 'Travel',
    4: 'Gifts',
    5: 'Education',
    6: 'Clothes',
    7: 'HealthCare',
    8: 'Groceries'
  };

  Expense(
      {required this.category,
      required this.name,
      required this.amount,
      required this.month,
      required this.createdAt});

  static Map<String, IconData> iconMapping = {
    'home': Icons.home,
    'shopping': Icons.shopping_cart,
    'travel': Icons.airplanemode_active,
    'gift': Icons.card_giftcard,
    'education': Icons.school,
    'clothes': Icons.checkroom,
    'healthcare': Icons.local_hospital,
    'groceries': Icons.local_grocery_store,
  };

  static List<Expense> expenses = [];

  static Future<void> addExpense(
      int cid, String name, double amount, String month) async {
    try {
      final url = Uri.parse("http://flutterapp1.atwebpages.com/addExp.php");
      final response = await http.post(url, body: {
        'category': cid.toString(),
        'name': name,
        'amount': amount.toString(),
        'month': month
      });
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        print(jsonResponse['message']);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<Expense>> getExpenses() async {
    try {
      final url = Uri.http(baseUrl, 'getExp.php');
      final response = await http.get(url);
      expenses.clear();
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        for (var row in jsonResponse) {
          String iconName = row['iconData'];
          IconData? icon = iconMapping[iconName.toLowerCase()];
          icon = icon ?? Icons.error;
          Expense exp = Expense(
              category: ECategory(
                  catName: row['cName'],
                  iconData: icon,
                  total: double.tryParse(row['total'])),
              name: row['name'],
              amount: double.tryParse(row['amount']),
              month: row['month'],
              createdAt: DateTime.tryParse(row['createdAt']));
          expenses.add(exp);
        }
      }
      return expenses;
    } catch (e) {
      print(e.toString());
      return expenses;
    }
  }

  static Future<List<Expense>> searchExpense(String q) async {
    final url = Uri.http(baseUrl, 'search.php', {'q': q});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      expenses.clear();
      for (var row in jsonResponse) {
        String iconName = row['iconData'];
        IconData? icon = iconMapping[iconName.toLowerCase()];
        icon = icon ?? Icons.error;
        Expense exp = Expense(
            category: ECategory(
                catName: row['cName'],
                iconData: icon,
                total: double.tryParse(row['total'])),
            name: row['name'],
            amount: double.tryParse(row['amount']),
            month: row['month'],
            createdAt: DateTime.tryParse(row['createdAt']));
        expenses.add(exp);
      }
    }
    return expenses;
  }
}

List<ECategory> categories = ECategory.categories;
