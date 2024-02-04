import 'package:flutter/material.dart';
import 'package:krita/ngo/mainPage.dart';
import 'package:krita/ngo/reusableWidgets/userRoleCard.dart';

import 'package:krita/constants.dart';

class userRole extends StatefulWidget {
  const userRole({super.key});

  @override
  State<userRole> createState() => _userRoleState();
}

class _userRoleState extends State<userRole> {
  int roleNo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_color,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_sharp),
          color: main_theme,
          iconSize: 30,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left:
                              MediaQuery.of(context).size.shortestSide * 0.1)),
                  const Text(
                    'Choose your',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Text(
                    'Role.',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: main_theme,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => setState(() {
                  roleNo = 1;
                }),
                child: userRole_Card(
                  heading: 'Organisation Head',
                  description:
                      'An NGO which consists of more than 100 active members',
                  isClicked: roleNo == 1 ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  roleNo = 2;
                }),
                child: userRole_Card(
                  heading: 'Community Head',
                  description:
                      'A group of people who stepped forward to help the needy.',
                  isClicked: roleNo == 2 ? true : false,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  roleNo = 3;
                }),
                child: userRole_Card(
                  heading: 'Volunteer',
                  description:
                      'Person who is willing to help the needy at any cost.',
                  isClicked: roleNo == 3 ? true : false,
                ),
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.7,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    if (roleNo != 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPage()));
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
            ]),
      ),
    );
  }
}
