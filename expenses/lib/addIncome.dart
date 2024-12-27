// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors
import 'income.dart';
import 'package:flutter/material.dart';

class Addincome extends StatefulWidget {
  const Addincome({super.key});

  @override
  State<Addincome> createState() => _AddincomeState();
}

class _AddincomeState extends State<Addincome> {
  TextEditingController incomeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedMonth;
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
  final Map<String, int> monthIndex = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'October': 10,
    'November': 11,
    'December': 12
  };

  void addIncome(int amount, String month) {
    Income.incomes.add(Income(amount: amount, month: month));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Income added successfully!')),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Add Income!',
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
                    controller: incomeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter income amount!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Income amount',
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
                  initialSelection: 'Select a month',
                  dropdownMenuEntries: month.map((mo) {
                    return (DropdownMenuEntry(value: mo, label: mo.toString()));
                  }).toList(),
                  onSelected: (value) {
                    setState(() {
                      selectedMonth = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          int? amount = int.tryParse(incomeController.text);
                          String? month = selectedMonth as String;
                          int monthNb = monthIndex[month] as int;
                          await Income.addIncome(amount as int, monthNb);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.blue,
                                content:
                                    Text('Income is Added SuccessFully!!')),
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('enter income and month correctly !')),
                          );
                        }
                        incomeController.clear();
                        selectedMonth == null;
                        setState(() {});
                      }
                    },
                    icon: Icon(
                      Icons.add,
                    ),
                    label: Text('ADD'),
                  ),
                ),
                const SizedBox(
                  height: 70.0,
                ),
                const Image(
                  image: AssetImage('assets/pngegg.png'),
                  width: 300.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
