import 'package:flutter/material.dart';
import 'package:souvenir/reusable_widgets/inputCard.dart';

import 'mainPage.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  static final String id = 'signup';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_sharp),
          color: Color.fromARGB(225, 25, 25, 25),
          iconSize: 30,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                'Souvenir',
                style: TextStyle(
                  fontFamily: 'WaitingfortheSunrise',
                  color: Color.fromARGB(225, 25, 25, 25),
                  fontSize: 85,
                ),
              ),
            ),

            //SignUp Container starts here
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.67,
              margin: const EdgeInsets.only(top: 35),
              decoration: const BoxDecoration(
                color: Color.fromARGB(225, 25, 25, 25),
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40.0), bottom: Radius.circular(0.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(34, 0, 0, 0),
                    offset: Offset(10, -10),
                    blurRadius: 15,
                    spreadRadius: 6.0,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Divider(
                    height: 10.0,
                  ),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontFamily: 'WaitingfortheSunrise',
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 70,
                            child: InputCard(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter name',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontFamily: 'WaitingfortheSunrise',
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 14,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            child: InputCard(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter email id',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontFamily: 'WaitingfortheSunrise',
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 14,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            child: InputCard(
                              child: TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Enter password',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontFamily: 'WaitingfortheSunrise',
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 14,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ),
                          );
                      },

                      label: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: 'WaitingfortheSunrise',
                          color: Color.fromARGB(225, 25, 25, 25),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontFamily: 'WaitingfortheSunrise',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const Ngo_SignInPage(),
                          //   ),
                          // );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontFamily: 'WaitingfortheSunrise',
                            fontSize: 24,
                            color: Color.fromARGB(255, 201, 144, 124)
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
