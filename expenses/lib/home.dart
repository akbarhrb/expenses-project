// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'components/listTile.dart';
import 'components/categoryBtn.dart';
import 'income.dart';
import 'expense.dart';
import 'expenses.dart';
import 'ECategory.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Expense> expenses = Expense.expenses;
  final List<String> month = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  int index = 0;
  int totalIncome = 0;

  @override
  void initState() {
    fetchCategories();
    fetchIncomes();
    fetchExpenses();
    super.initState();
    setState(() {});
    calculateTotalIncome();
    calculateTotalExpenses();
  }

  void calculateTotalIncome() {
    totalIncome = Income.incomes
        .where((income) => income.month == month[index])
        .fold(0, (sum, income) => sum + (income.amount ?? 0));
    setState(() {});
  }

  int totalExpenses = 0;

  void calculateTotalExpenses() {
    totalExpenses = Expense.expenses
        .where((expense) => expense.month == month[index])
        .fold(0, (sum, expense) => sum + (expense.amount?.toInt() ?? 0));
    setState(() {});
  }

  void fetchCategories() async {
    await ECategory.getCat();
    setState(() {});
  }

  Expense? lastExp;
  bool loaded = false;
  void fetchExpenses() async {
    loaded = false;
    expenses = await Expense.getExpenses();
    lastExp = expenses[expenses.length - 1];
    setState(() {});
    loaded = true;
  }

  void fetchIncomes() async {
    await Income.getIncomes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 30.0), // Top space
          Align(
            alignment: Alignment.center,
            child: Container(
              width: screenWidth * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 5.0),
                      Text(
                        'let\'s manage your expenses!',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/addIncome');
                          },
                          child: Icon(
                            Icons.wallet,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/addExpense');
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
              width: screenWidth * 0.9,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                    decoration: BoxDecoration(),
                    child: IconButton(
                      onPressed: () {
                        if (index == 0) {
                          index = month.length - 1;
                        } else {
                          index -= 1;
                        }
                        fetchIncomes();
                        calculateTotalIncome();
                        calculateTotalExpenses();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.arrow_circle_left,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                  ),
                  Text(
                    month[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      decoration: BoxDecoration(),
                      child: IconButton(
                          onPressed: () {
                            if (index == month.length - 1) {
                              index = 0;
                            } else {
                              index += 1;
                            }
                            fetchIncomes();
                            calculateTotalIncome();
                            calculateTotalExpenses();
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.arrow_circle_right,
                            color: Colors.white,
                            size: 40.0,
                          ))),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: screenWidth * 0.9,
              margin: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
              height: 200.0,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  Text(
                    '${totalIncome - totalExpenses}\$',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45.0,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: const Color(0xfffffff9),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 7, 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Icon(
                                Icons.arrow_downward,
                                color: Colors.green,
                                size: 40.0,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "INCOME",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '$totalIncome\$',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20.0,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: const Color(0xfffffff9),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 7, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: Colors.red,
                                  size: 40.0,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Expense",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '$totalExpenses\$',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20.0,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
              width: screenWidth * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryExpensesPage(category: categories[0]),
                        ),
                      );
                    },
                    child: CategoryBtn(
                      title: 'Home',
                      catIcon: Icons.home_filled,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryExpensesPage(category: categories[1]),
                        ),
                      );
                    },
                    child: CategoryBtn(
                      title: 'Shopping',
                      catIcon: Icons.shopping_cart_sharp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryExpensesPage(category: categories[2]),
                        ),
                      );
                    },
                    child: CategoryBtn(
                      title: 'Travel',
                      catIcon: Icons.airplanemode_on,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/categories',
                      );
                    },
                    child: CategoryBtn(
                      title: 'All',
                      catIcon: Icons.more_horiz,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
              width: screenWidth * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "last Expenses",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/allExpenses');
                    },
                    child: const Text(
                      "See All / Search",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          loaded == false
              ? Align(
                  child: Container(
                  margin: EdgeInsets.fromLTRB(0, 70.0, 0, 0),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                ))
              : Align(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return CustomListTile(
                            name: expenses[expenses.length - index - 1].name
                                as String,
                            category: expenses[expenses.length - index - 1]
                                .category as ECategory,
                            date: expenses[expenses.length - index - 1]
                                .createdAt as DateTime,
                            amount: expenses[expenses.length - index - 1].amount
                                as double,
                            month: expenses[expenses.length - index - 1].month
                                as String);
                      }),
                )
        ],
      ),
    );
  }
}
