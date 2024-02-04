import 'package:flutter/material.dart';
import 'package:krita/donate/SignUp.dart';
import 'package:krita/ngo/ngo_signup.dart';
import 'package:krita/provider/authentication.dart';
import 'package:krita/provider/sign_in_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'firebase_options.dart';
import 'homePage.dart';
import 'donate/SignIn.dart';
import 'ngo/ngo_signin.dart';
import 'constants.dart';

void main() async {
  //Initialise Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        // create: (context) => Authentication(),
        providers: [
          ChangeNotifierProvider<Authentication>(create: (_) => Authentication()),
          ChangeNotifierProvider<Auth>(create: (_) => Auth()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.yellow[700],
              secondary: Colors.yellow.shade700,
            ),
          ),
          home: SplashScreen(),
        ),
      );
}

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the HomePage widget.
        '/': (context) => const HomePage(),
        // When navigating to the "/donate_SignIn" route, build the SignIn widget of donate branch.
        '/donate_SignIn': (context) => const SignInPage(),
        // When navigating to the "/donate_SignUp" route, build the SignUp widget of donate branch.
        '/donate_SignUp': (context) => const SignUpPage(),
        // When navigating to the "/ngo_SignIn" route, build the SignIn widget of ngo branch.
        '/ngo_SignIn': (context) => const Ngo_SignInPage(),
        // When navigating to the "/ngo_SignUp" route, build the SignIn widget of ngo branch.
        '/ngo_SignUp': (context) => const Ngo_SignUpPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: main_theme,
      child: const Center(
        child: Text(
          'Krita',
          style: TextStyle(
            fontFamily: 'SAMAN',
            color: Colors.white,
            fontSize: 105,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
