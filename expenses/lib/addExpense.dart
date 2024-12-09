import 'package:flutter/material.dart';
import 'Category.dart';
import 'expense.dart';

class Addexpense extends StatefulWidget {
  const Addexpense({super.key});

  @override
  State<Addexpense> createState() => _AddexpenseState();
}

class _AddexpenseState extends State<Addexpense> {
  TextEditingController expenseName = TextEditingController();
  TextEditingController expenseAmount = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedMonth;
  Category? selectedCat;
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

  List<Category> categories = Category.categories;
  void addExpense(Category cat, String name, double amount) {
    Expense.expenses.add(Expense(
        category: cat,
        name: name,
        amount: amount,
        month: selectedMonth,
        createdAt: DateTime.now()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Expense added successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Add Expense!',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    controller: expenseName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter expense name!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter expense name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    controller: expenseAmount,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter expense amount!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter expense amount',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                DropdownMenu(
                  width: MediaQuery.of(context).size.width * 0.8,
                  dropdownMenuEntries: categories.map((cat) {
                    return (DropdownMenuEntry(
                        value: cat, label: cat.toString()));
                  }).toList(),
                  onSelected: (value) {
                    setState(() {
                      selectedCat = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                DropdownMenu(
                  width: MediaQuery.of(context).size.width * 0.8,
                  dropdownMenuEntries: month.map((mo) {
                    return (DropdownMenuEntry(value: mo, label: mo.toString()));
                  }).toList(),
                  onSelected: (value) {
                    selectedMonth = value;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String expName = expenseName.text;
                        double? amount = double.tryParse(expenseAmount.text);
                        if (selectedCat == null || selectedMonth == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('enter both month and category!')),
                          );
                        }
                        try {
                          addExpense(selectedCat as Category, expName,
                              amount as double);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('enter expense as a number!')),
                          );
                        }
                      }
                      expenseName.clear();
                      expenseAmount.clear();
                      setState(() {
                        selectedCat = null;
                        selectedMonth = null;
                      });
                    },
                    icon: Icon(
                      Icons.add,
                    ),
                    label: Text('ADD'),
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Image(
                  image: AssetImage(
                    'assets/addExpense.png',
                  ),
                  width: MediaQuery.of(context).size.width * 0.75,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
