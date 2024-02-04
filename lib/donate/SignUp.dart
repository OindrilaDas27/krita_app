import 'package:flutter/material.dart';
import 'package:krita/donate/userFeed.dart';
import '../constants.dart';
import '../ngo/reusableWidgets/formInput_Card.dart';
import '../provider/authentication.dart';
import '../provider/sign_in_provider.dart';
import 'SignIn.dart';

const color = Color.fromARGB(230, 247, 149, 30);

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _State createState() => _State();
}

Auth auth = Auth();
final myController = TextEditingController();
final _formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _State extends State<SignUpPage> {
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
            color: color,
            iconSize: 30,
            //replace with our own icon data.
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        // resizeToAvoidBottomInset: false,
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
                    const Divider(
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
                        onPressed: () async {
                          String? success = await auth.signUpWithEmail(
                              nameController.text,
                              emailController.text,
                              passwordController.text);
                          if (_formKey.currentState!.validate()) {
                            //   SIgnUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                            // }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserFeed(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Please enter all the details')));
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
                    const SizedBox(
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
                                builder: (context) => const SignInPage(),
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
      ),
    );
  }
}
