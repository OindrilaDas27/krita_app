import 'package:flutter/material.dart';
import 'package:krita/constants.dart';
import 'package:krita/donate/SignIn.dart';
import 'package:krita/donate/main.dart';
import 'package:krita/donate/userFeed.dart';
import 'package:krita/ngo/reusableWidgets/userRoleCard.dart';

class form extends StatefulWidget {
  const form({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<form> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Krita',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: main_theme,
            iconSize: 30,
            //replace with our own icon data.
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: bg_color,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.shortestSide * 0.1,
                      top: 100),
                ),
                Text('Choose your ',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    )),
                Text('Role.',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: main_theme,
                    )),
              ],
            ),
            GestureDetector(
              onTap: () => setState(() {
                count = 1;
              }),
              child: userRole_Card(
                heading: '',
                description: '',
                isClicked: count == 1 ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                count = 2;
              }),
              child: userRole_Card(
                heading: '',
                description: '',
                isClicked: count == 2 ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                count = 3;
              }),
              child: userRole_Card(
                heading: '',
                description: '',
                isClicked: count == 3 ? true : false,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.7,
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (count != 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserFeed(),
                        ));
                  }
                },
                label: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                backgroundColor: main_theme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
