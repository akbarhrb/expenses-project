// ignore_for_file: prefer_const_constructors
import 'package:intl/intl.dart';
import 'package:expenses/Category.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String name;
  final Category category;
  final DateTime date;
  final String month;
  final double amount;

  const CustomListTile(
      {Key? key,
      required this.name,
      required this.category,
      required this.date,
      required this.amount,
      required this.month})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        border: Border(
          bottom: BorderSide(
            color: Colors.blue,
            width: 1,
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.85,
      padding: EdgeInsets.all(5.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text('${month} ${DateFormat('EEEE d').format(date)}'),
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              category.iconData,
              size: 25.0,
              color: Colors.white,
            ),
          ),
        ),
        trailing: Text(
          '\$$amount',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
