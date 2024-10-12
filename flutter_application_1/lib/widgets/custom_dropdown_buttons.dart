import 'package:flutter/material.dart';

class CustomDropdownButtons extends StatelessWidget{
  List<String> itemsList;
  double width;

  CustomDropdownButtons({required this.itemsList, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromRGBO(53, 53, 53, 1.0),
        ),
        child: DropdownButton<String>(
      underline: Container(),
      value: itemsList.first,
      items: itemsList
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (_) {},
      dropdownColor: const Color.fromRGBO(53, 53, 53, 1.0),
      style: const TextStyle(color: Colors.white),
    ));
  }
}