// ignore_for_file: avoid_print

import 'package:expenses/ECategory.dart';
import 'package:expenses/components/listTile.dart';
import 'package:expenses/expense.dart';
import 'package:flutter/material.dart';

class Allexpenses extends StatefulWidget {
  const Allexpenses({super.key});

  @override
  State<Allexpenses> createState() => _AllexpensesState();
}

class _AllexpensesState extends State<Allexpenses> {
  TextEditingController query = TextEditingController();
  bool loaded = false;

  Future<List<Expense>> fetchExpenses() async {
    setState(() {
      loaded = false;
    });
    expenses = await Expense.getExpenses();

    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        loaded = true;
      });
    });
    return expenses;
  }

  @override
  void initState() {
    super.initState();
    fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'All Expenses',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Align(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                    width: screenWidth * 0.8,
                    child: TextFormField(
                      controller: query,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    )),
              )),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20.0, 10, 0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: IconButton(
                    onPressed: () async {
                      try {
                        expenses = await Expense.searchExpense(query.text);
                        print(expenses);
                        setState(() {});
                      } catch (e) {
                        print("===============error===========");
                        print(e.toString());
                      }
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          loaded == false
              ? Align(
                  child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 70.0, 0, 0),
                  child: const SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                ))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    return CustomListTile(
                        name: expenses[index].name as String,
                        category: expenses[index].category as ECategory,
                        date: expenses[index].createdAt as DateTime,
                        amount: expenses[index].amount as double,
                        month: expenses[index].month as String);
                  }),
        ],
      ),
    );
  }
}
