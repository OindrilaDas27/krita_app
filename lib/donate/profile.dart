import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krita/constants.dart';

import '../provider/authentication.dart';

User? userr;
List<Map<String, dynamic>> _users = [];
int count = 0;

class profile extends StatefulWidget {
  const profile({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  profileState createState() => profileState(this._user);
}

class profileState extends State<profile> {
  final User _user;

  profileState(this._user);

  Future<void> credits() async {
    userr = FirebaseAuth.instance.currentUser;
    final Users =
        FirebaseFirestore.instance.collection('Users').doc(userr!.uid);
    final userpost = Users.collection('userpost');

    final QuerySnapshot snapshot = await userpost.get();
    final List<QueryDocumentSnapshot> documents = snapshot.docs;
    final List<Map<String, dynamic>> userslist =
        documents.map((doc) => doc.data() as Map<String, dynamic>).toList();
    setState(() {
      _users = userslist;
    });
    setState(() {
      count = _users.length;
    });
  }

  @override
  void initState() {
    super.initState();
    credits();
  }

  Widget build(BuildContext context) {
    bool isSigningOut = false;

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
                iconSize: 30,
                //replace with our own icon data.
              ),
              backgroundColor: main_theme,
              elevation: 0,
            ),
            backgroundColor: bg_color,
            // resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.shortestSide * 0.1,
                      top: 60),
                ),
                Row(),
                _user.photoURL != null
                    ? ClipOval(
                        child: Material(
                          color: Colors.grey.withOpacity(0.3),
                          child: Image.network(
                            _user.photoURL!,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    : ClipOval(
                        child: Material(
                          color: Colors.grey.withOpacity(0.3),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hello, ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: main_theme,
                        ),
                      ),
                      Text(
                        _user.displayName!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        '!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          count.toString(),
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          "Donations",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 59, 58, 58)),
                        )
                      ],
                    ),
                    Column(
                      children: const [
                        Text(
                          "11",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Referrals",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 59, 58, 58)),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          count.toString(),
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          "Credits",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 59, 58, 58)),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40.0),
                Divider(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Send a Refferal",
                    style: TextStyle(
                      color: Color.fromARGB(214, 53, 51, 51),
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Divider(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "How to use credits?",
                    style: TextStyle(
                      color: Color.fromARGB(214, 53, 51, 51),
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Divider(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Help",
                    style: TextStyle(
                      color: Color.fromARGB(214, 53, 51, 51),
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Divider(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "FAQs",
                    style: TextStyle(
                      color: Color.fromARGB(214, 53, 51, 51),
                      fontSize: 15.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                FloatingActionButton.extended(
                  onPressed: () async {
                    setState(() {
                      isSigningOut = true;
                    });
                    await FirebaseAuth.instance.signOut();
                    setState(() {
                      isSigningOut = false;
                    });
                  },
                  label: const Text(
                    "Sign out",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  backgroundColor: main_theme,
                )
              ],
            )));
  }
}
