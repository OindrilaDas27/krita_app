import 'package:flutter/material.dart';
import 'package:krita/constants.dart';

class capsule_Card extends StatelessWidget {
  String meal_type;
  bool isClicked;

  capsule_Card({key, required this.meal_type, required this.isClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      // width: 70,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isClicked ? main_theme : Color.fromARGB(225, 230, 228, 228),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        meal_type,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isClicked ? Colors.white : Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
