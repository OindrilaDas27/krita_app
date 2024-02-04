import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:krita/donate/form.dart';
import 'package:krita/donate/userFeed.dart';
import 'SignUp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:krita/provider/sign_in_provider.dart';
import 'package:krita/constants.dart';

//const color = Color.fromARGB(230, 247, 149, 30);

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  
  @override
  _State createState() => _State();
}

class _State extends State<SignInPage> {
  bool _isSigningIn = false;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => form(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> siginwithgoogle() async {
    setState(() {
      _isSigningIn = true;
    });
    User? user = await Authentication.signInWithGoogle(context: context);
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserFeed(),
        ),
      );
    }
    setState(() {
      _isSigningIn = false;
    });
  }

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
                color: main_theme,
                iconSize: 30,
                //replace with our own icon data.
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: bg_color,
            // resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Center(
                  child: Container(
                      child: Column(children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    alignment: Alignment.center,
                    child: const Text(
                      'Krita',
                      style: TextStyle(
                          fontFamily: 'SAMAN',
                          color: main_theme,
                          fontSize: 105),
                    )),
                //sign up container
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            color: Color.fromARGB(34, 0, 0, 0),
                            offset: Offset(10, -10),
                          ),
                        ],
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                          bottom: Radius.circular(0),
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40),
                            bottom: Radius.circular(0),
                          ),
                          color: Color.fromARGB(246, 255, 255, 255),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 50,
                                ),
                                child: const Text('Welcome',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: main_theme,
                                    )),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                height: 45,
                                width: 350,
                                margin: const EdgeInsets.only(
                                  top: 15,
                                ),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: Color.fromARGB(127, 227, 227, 227),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(14),
                                  child: TextField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      hintText: "Email Id",
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                      color: Color.fromARGB(235, 117, 117, 117),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 45,
                                width: 350,
                                margin: const EdgeInsets.only(
                                  top: 15,
                                  bottom: 20,
                                ),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: Color.fromARGB(127, 227, 227, 227),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(14),
                                  child: TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      hintText: "Password",
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                      color: Color.fromARGB(235, 117, 117, 117),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              isLoading
                                  ? CircularProgressIndicator()
                                  : SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: FloatingActionButton.extended(
                                        onPressed: () {
                                          _signInWithEmailAndPassword();
                                          const snackBar = SnackBar(
                                              content:
                                                  Text("You're Logged In"));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
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
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                'or sign in with',
                                style: TextStyle(
                                  color: main_theme,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(FontAwesome.phone),
                                  ),
                                  _isSigningIn
                                      ? CircularProgressIndicator()
                                      : IconButton(
                                          onPressed: () {
                                            siginwithgoogle();
                                          },
                                          icon: Logo(Logos.google),
                                        ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Logo(Logos.facebook_logo),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: const Text(
                                        'Don\'t have an account?',
                                      ),
                                    ),
                                    Container(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUpPage(),
                                              ));
                                        },
                                        child: const Text(
                                          'Sign Up here',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]))),
            )));
  }
}
