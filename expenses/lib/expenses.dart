// ignore_for_file: prefer_const_constructors

import 'package:expenses/components/listTile.dart';
import 'package:flutter/material.dart';
import 'expense.dart';
import 'ECategory.dart';

class CategoryExpensesPage extends StatefulWidget {
  final ECategory category;

  const CategoryExpensesPage({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryExpensesPage> createState() => _CategoryExpensesPageState();
}

class _CategoryExpensesPageState extends State<CategoryExpensesPage> {
  void fetchExpenses() async {
    await Expense.getExpenses();
    setState(() {});
  }

  @override
  void initState() {
    fetchExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Filter expenses for the selected category
    List<Expense> filteredExpenses = Expense.expenses
        .where(
            (expense) => expense.category?.catName == widget.category.catName)
        .toList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 5.0,
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text(
          '${widget.category.catName} Expenses',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView.builder(
                  itemCount: filteredExpenses.length,
                  itemBuilder: (context, index) {
                    final expense = filteredExpenses[index];
                    return CustomListTile(
                        name: expense.name as String,
                        category: expense.category as ECategory,
                        month: expense.month as String,
                        date: expense.createdAt as DateTime,
                        amount: expense.amount as double);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
