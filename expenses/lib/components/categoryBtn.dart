import 'package:flutter/material.dart';

class CategoryBtn extends StatefulWidget {
  final String title;
  final IconData catIcon;

  const CategoryBtn({Key? key, required this.title, required this.catIcon})
      : super(key: key);

  @override
  State<CategoryBtn> createState() => _CategoryBtnState();
}

class _CategoryBtnState extends State<CategoryBtn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blue, // Set your border color
              width: 2.0, // Set your border width
            ),
          ),
          child: CircleAvatar(
            radius: 35.0,
            backgroundColor: Color(0xfff1e4e4),
            child: Icon(
              widget.catIcon,
              color: Colors.blueAccent,
              size: 30.0,
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
