import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Hey!',
          style: TextStyle(
            fontFamily: 'HappyMonkey',
            color: Color.fromARGB(225, 25, 25, 25),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_2_outlined),
            color: Color.fromARGB(225, 25, 25, 25),
            iconSize: 30,
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/main_screen.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(fontFamily: 'HappyMonkey'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    borderSide: BorderSide(
                      width: 5.0,
                    ),
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CircleNavBar(
        activeIndex: 1,
        activeIcons: [
          Icon(Icons.home_outlined, color: Color.fromARGB(225, 255, 204, 184)),
          Icon(Icons.add, color: Color.fromARGB(225, 255, 204, 184)),
          Icon(Icons.bookmark_border, color: Color.fromARGB(225, 255, 204, 184)),
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
