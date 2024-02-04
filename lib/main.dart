import 'dart:async';

import 'package:flutter/material.dart';
import 'package:souvenir/mainPage.dart';
import 'package:souvenir/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Souvenir',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Signup()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         constraints: BoxConstraints.expand(),
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage("assets/images/splash_screen.png"),
             fit: BoxFit.cover,
           )
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Text(
               'Souvenir',
               style: TextStyle(
                 fontSize: 40,
                 fontFamily: 'WaitingfortheSunrise',
                 color: Colors.white,
               ),
             )
           ],
         ),
       ),
    );
  }
}
