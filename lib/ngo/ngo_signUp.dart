import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:krita/controller/signup_controller.dart';
import 'package:krita/ngo/reusableWidgets/formInput_Card.dart';
import 'package:krita/ngo/ngo_signIn.dart';
import 'package:krita/ngo/userRole.dart';
import 'package:krita/constants.dart';
import 'package:krita/provider/authentication.dart';

class Ngo_SignUpPage extends StatefulWidget {
  const Ngo_SignUpPage({super.key});

  static final String id = 'signup';

  @override
  State<Ngo_SignUpPage> createState() => _Ngo_SignUpPageState();
}

class _Ngo_SignUpPageState extends State<Ngo_SignUpPage> {

  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Auth auth = Auth();

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                'Krita',
                style: TextStyle(
                  fontFamily: 'SAMAN',
                  color: main_theme,
                  fontSize: 105,
                ),
              ),
            ),

            //SignUp Container starts here
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.67,
              margin: const EdgeInsets.only(top: 35),
              decoration: const BoxDecoration(
                color: bg_color,
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
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: main_theme,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 70,
                            child: InputCard(
                              child: TextFormField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter name',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(127, 117, 117, 117),
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
                                controller: emailController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter email id',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(127, 117, 117, 117),
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
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Enter password',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(127, 117, 117, 117),
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
                          Container(
                            height: 70,
                            child: InputCard(
                              child: TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Confirm Password',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(127, 117, 117, 117),
                                    fontSize: 14,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter correct password';
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
                      onPressed: () async{
                        String? success = await auth.signUpWithEmail(nameController.text, emailController.text, passwordController.text);
                        if(_formKey.currentState!.validate()) {
                          //   SIgnUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                          // }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const userRole(),
                            ),
                          );
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please enter all the details'))
                          );
                        }
                      },

                      label: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: main_theme,
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
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Ngo_SignInPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign In here',
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
