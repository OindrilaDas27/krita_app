import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:krita/constants.dart';
import 'package:krita/donate/createpost.dart';

User? userr;
String? posttime;
int? days, time, hrs, minutes;
String? type;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, dynamic>> _filteredData = [];
  TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    // _filteredData = _users;
    // _searchController.addListener(() {
    //   filterData();
    // });
    // void filterData() {
    //   List<String> tempList = [];
    //   for (int i = 0; i < _users.length; i++) {
    //     if (_users[i].contains(_searchController.text.toLowerCase())) {
    //       tempList.add(_users[i]);
    //     }
    //   }
    //   setState(() {
    //     _filteredData = tempList;
    //   });
    // }
  }

  Future<void> fetchData() async {
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
  }

  time() {
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.parse(posttime!);
    Duration timeLeft = endDate.difference(startDate);
    days = timeLeft.inDays;
    hrs = timeLeft.inHours % 24;
    minutes = timeLeft.inMinutes % 60;
    if (days! > 0 && hrs! > 0 && minutes! > 0) {
      return Text('Exp $days days $hrs hrs $minutes min');
    } else {
      return Text('Expired');
    }
  }

  bool veg = false;

  bool vegnonveg() {
    if (type == 'veg' || type == 'Veg') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        //removes back button from appbar.
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          width: 100,
          height: 40.0,
          margin:
              const EdgeInsets.only(left: 40, right: 100, top: 8, bottom: 8),
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(
              color: Color.fromARGB(73, 158, 158, 158),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(
            children: const [
              Icon(
                Icons.search,
                color: Colors.black,
              ),
              // TextField(

              //   textAlign: TextAlign.start,
              //   controller: _searchController,
              //   decoration: const InputDecoration(
              //       hintText: 'Search', border: InputBorder.none),
              // ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Bootstrap.sliders,
              color: main_theme,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (BuildContext context, int index) {
          final Map<String, dynamic> user = _users[index];
          posttime = user['date'];
          type = user['veg/nonveg'];
          time();
          return Container(
            margin: const EdgeInsets.all(40),
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color.fromARGB(255, 255, 255, 255),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  color: Color.fromARGB(34, 0, 0, 0),
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      maxRadius: 20,
                      minRadius: 20,
                      backgroundImage:
                          CachedNetworkImageProvider(userr!.photoURL!),
                    ),
                    Column(
                      children: [
                        Text(
                          user['displayName'],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.verified,
                              color: Colors.blue,
                            ),
                            Text(
                              "Verified",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 38.0),
                    IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                Container(
                    child: Image.network(
                  user['mediaurl'],
                  // height: 300,
                  // width: MediaQuery.of(context).size.width * 0.7,
                )),
                const Padding(padding: EdgeInsets.only(top: 15)),
                Text(
                  user['msg'],
                  style: const TextStyle(
                      color: Color.fromARGB(255, 94, 91, 91),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          constraints:
                              const BoxConstraints(minWidth: 50, maxWidth: 100),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: const Color.fromARGB(100, 79, 79, 79),
                            ),
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Bootstrap.bell,
                                size: 15.0,
                                color: Colors.amber,
                              ),
                              Text(user['quantity'] + ' meals'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        vegnonveg()
                            ? Container(
                                height: 30,
                                width: 45,
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.5,
                                    color:
                                        const Color.fromARGB(255, 76, 126, 58),
                                  ),
                                  color:
                                      const Color.fromARGB(255, 221, 253, 196),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  'Veg',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 76, 126, 58),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : Container(
                                height: 30,
                                // width: 70,
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.5,
                                    color:
                                        const Color.fromARGB(255, 242, 84, 84),
                                  ),
                                  color:
                                      const Color.fromARGB(255, 255, 215, 215),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  'Non-Veg',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 242, 84, 84),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                        Container(
                          height: 30,
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: const Color.fromARGB(100, 79, 79, 79),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 15.0,
                                color: Color.fromARGB(255, 218, 242, 84),
                              ),
                              Text("2km")
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 30,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: const Color.fromARGB(255, 255, 215, 215),
                            ),
                            color: const Color.fromARGB(255, 255, 215, 215),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Bootstrap.clock,
                                size: 15.0,
                                color: Color.fromARGB(255, 242, 84, 84),
                              ),
                              time(),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
