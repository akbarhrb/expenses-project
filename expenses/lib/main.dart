import 'package:expenses/addIncome.dart';
import 'package:flutter/material.dart';
import 'categories.dart';
import 'home.dart';
import 'addExpense.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/categories': (context) => Categories(),
      '/addIncome': (context) => Addincome(),
      '/addExpense': (context) => Addexpense(),
    },
  ));
}
