import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:krita/donate/main.dart';

import 'package:krita/ngo/reusableWidgets/formInput_Card.dart';
import 'package:krita/ngo/ngo_signup.dart';
import 'package:krita/ngo/userRole.dart';
import 'package:krita/constants.dart';
import 'package:krita/provider/authentication.dart';
import 'package:provider/provider.dart';

class Ngo_SignInPage extends StatefulWidget {
  const Ngo_SignInPage({super.key});

  @override
  State<Ngo_SignInPage> createState() => _Ngo_SignInPageState();
}

class _Ngo_SignInPageState extends State<Ngo_SignInPage> {
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    String? uidProvider = context.watch<Auth>().uid;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 70),
                child: const Text(
                  'Krita',
                  style: TextStyle(
                      fontFamily: 'SAMAN', color: main_theme, fontSize: 105),
                ),
              ),

              //SignIn Container starts here
              SizedBox(
                height: MediaQuery.of(context).size.height - 242,
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  decoration: const BoxDecoration(
                    color: bg_color,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40.0),
                        bottom: Radius.circular(0.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(34, 0, 0, 0),
                        offset: Offset(10, -10),
                        blurRadius: 15,
                        spreadRadius: 6.0,
                      )
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: main_theme,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 70,
                              child: InputCard(
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    hintText: 'User Name',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(127, 117, 117, 117),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 70,
                              child: InputCard(
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: 'Password',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(127, 117, 117, 117),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: FloatingActionButton.extended(
                          onPressed: () async {
                            String? success = await auth.signInWithEmail(
                                emailController.text, passwordController.text);
                            if (success != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const userRole(),
                                ),
                              );
                              final snackBar = const SnackBar(
                                  content: Text("You're Logged In"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          label: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          backgroundColor: main_theme,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'or sign in with',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Logo(Logos.facebook_logo)),
                          Consumer<Auth>(
                            builder: (context, auth, child) {
                              return TextButton(
                                  onPressed: () async {
                                    User? user = await auth.signInWithGoogle();
                                    print(auth.uidReturn);
                                    print(user);
                                    if (user != null) {
                                      bool isUserRegistered = await auth
                                          .isUserRegistered(uidProvider);
                                      if (isUserRegistered) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainPage(),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const userRole(),
                                          ),
                                        );
                                      }
                                      final snackBar = const SnackBar(
                                          content: Text("You're Logged In"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: Logo(Logos.google));
                            },
                          ),
                          TextButton(
                              onPressed: () {}, child: Icon(FontAwesome.phone)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Ngo_SignUpPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign Up here',
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
