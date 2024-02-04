import 'package:flutter/material.dart';

import 'package:krita/constants.dart';

class userRole_Card extends StatelessWidget {
  final String heading;
  final String description;
  bool isClicked;

  userRole_Card(
      {key,
      required this.heading,
      required this.description,
      required this.isClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 20.0),
      color: isClicked
          ? Color.fromARGB(230, 255, 227, 168)
          : Color.fromARGB(225, 230, 228, 228),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        side: BorderSide(
          color: isClicked
              ? main_theme
              : Color.fromARGB(225, 230, 228, 228),
          width: 2,
        ),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              // const SizedBox(height: 3.0,),
              Text(
                description,
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 49, 49, 49)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
