// ignore_for_file: prefer_const_constructors

import 'ECategory.dart';
import 'expense.dart';
import 'expenses.dart';
import 'components/categoryBtn.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<ECategory> categories = ECategory.categories;

  void calculateAllCategoryTotals() {
    for (var category in ECategory.categories) {
      category.calculateTotal(Expense.expenses);
    }
  }

  bool loaded = false;
  void fetchCategories() async {
    loaded = false;
    await ECategory.getCat();
    calculateAllCategoryTotals();
    loaded = true;
    setState(() {});
  }

  @override
  void initState() {
    fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Categories',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            // SizedBox(
            //   height: 20.0,
            // ),
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
                : Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CategoryBtn(
                                    title: categories[index].catName ??
                                        'Unknown Category',
                                    catIcon:
                                        categories[index].iconData ?? Icons.abc,
                                  ),
                                  Spacer(),
                                  Text(
                                    '${categories[index].total} \$',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.purple),
                                  ),
                                  SizedBox(height: 13.0),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: FilledButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryExpensesPage(
                                                    category:
                                                        categories[index]),
                                          ),
                                        );
                                      },
                                      child: const Text('show all'),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
