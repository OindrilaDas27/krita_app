import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // toolbarHeight: 120,
        title: Text(
          'Hey!',
          style: TextStyle(
            fontFamily: 'HappyMonkey',
            color: Color.fromARGB(225, 25, 25, 25),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () { },
            icon: const Icon(Icons.person_2_outlined),
            color: Color.fromARGB(225, 25, 25, 25),
            iconSize: 30,
          )
        ],

      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/main_screen.png"),
              fit: BoxFit.cover,
            )
        ),
      ),
      bottomNavigationBar: CircleNavBar(
        activeIndex: 1,
        activeIcons: [
          Icon(Icons.home_outlined, color: Color.fromARGB(225, 255, 204, 184),),
          Icon(Icons.add, color: Color.fromARGB(225, 255, 204, 184),),
          Icon(Icons.bookmark_border, color: Color.fromARGB(225, 255, 204, 184),),
        ],
        inactiveIcons: [
          Text("Home"),
          Text("Create"),
          Text("Saved"),
        ],
        height: 60,
        circleWidth: 60,
        color: Color.fromARGB(225, 25, 25, 25),
      ),
    );
  }
}
