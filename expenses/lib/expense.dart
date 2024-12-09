import 'Category.dart';

class Expense {
  Category? category;
  String? name;
  double? amount;
  String? month;
  DateTime? createdAt;

  Expense(
      {required this.category,
      required this.name,
      required this.amount,
      required this.month,
      required this.createdAt});

  static List<Expense> expenses = [
    Expense(
        category: categories[0],
        name: 'rent',
        amount: 300,
        month: 'January',
        createdAt: DateTime.now()),
    Expense(
        category: categories[1],
        name: 'pants',
        amount: 150,
        month: 'February',
        createdAt: DateTime.now()),
    Expense(
        category: categories[3],
        name: 'iphone 11',
        amount: 1200,
        month: 'January',
        createdAt: DateTime.now()),
    Expense(
        category: categories[7],
        name: 'vegetables',
        amount: 60,
        month: 'February',
        createdAt: DateTime.now()),
    Expense(
        category: categories[2],
        name: 'to Paris',
        amount: 800,
        month: 'May',
        createdAt: DateTime.now()),
    Expense(
        category: categories[2],
        name: 'to lebanon',
        amount: 800,
        month: 'June',
        createdAt: DateTime.now()),
    Expense(
        category: categories[4],
        name: 'payment nb1',
        amount: 400,
        month: 'May',
        createdAt: DateTime.now()),
  ];
}

List<Category> categories = Category.categories;
