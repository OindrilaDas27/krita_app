import 'package:flutter/material.dart';
import 'package:souvenir/pages/home.dart';
import 'package:souvenir/pages/loading.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Souvenir',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => LoadingPage(),
        '/home': (context) => MyHomePage(),
      },
    );
  }
}
