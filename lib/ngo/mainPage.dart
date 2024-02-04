import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krita/backend/ngo/models/NgoCreatePostModel.dart';
import 'package:krita/constants.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:krita/ngo/ngo_createPost.dart';
import 'package:krita/ngo/ngo_userProfile.dart';
import 'package:krita/ngo/reusableWidgets/donationPostDetails.dart';
import 'package:krita/provider/authentication.dart';
import 'package:provider/provider.dart';

import '../backend/ngo/database/ngoCreatePost.dart';
import '../homePage.dart';
import '../provider/sign_in_provider.dart';

class MainPage extends StatefulWidget {
  String? email;
  User? userr;
  String? posttime;
  int? days, time, hrs, minutes;

  MainPage({key, this.email}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  Authentication auth = Authentication();

  var _bottomNavIndex = 0;
  final iconList = <IconData>[
    Bootstrap.house_door,
    Bootstrap.chat_dots,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_sharp),
          color: main_theme,
          iconSize: 30,
        ),
        actions: [
          IconButton(
            onPressed: () {
              _key.currentState!.openEndDrawer();
            },
            icon: const Icon(Icons.person),
            color: main_theme,
            iconSize: 50,
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      endDrawer: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text(
                  "Hello Ame!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                accountEmail: Text(
                  "email",
                ),
                currentAccountPicture: ProfilePicture(
                  name: 'Ame',
                  radius: 20,
                  fontsize: 21,
                  random: true,
                  count: 2,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Bootstrap.person_fill_gear,
                  color: main_theme,
                ),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ngo_userProfile(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Bootstrap.building_fill_gear,
                  color: main_theme,
                ),
                title: const Text('Change Address'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Bootstrap.person_vcard,
                  color: main_theme,
                ),
                title: const Text('Account Details'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(
                color: Colors.black,
              ),
              ListTile(
                leading: const Icon(
                  Bootstrap.box_arrow_right,
                  color: main_theme,
                ),
                title: const Text('Log Out'),
                onTap: () async {
                  await context.read<Auth>().logout();

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (BuildContext) => const HomePage()),
                      (route) => false);
                  final snackBar =
                      const SnackBar(content: Text("You're Logged Out"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.6,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Color.fromARGB(127, 227, 227, 227),
                        ),
                        // child: Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          // controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search...',
                            // suffixIcon: IconButton(
                            //   onPressed: () {},
                            //   icon: Icon(Icons.clear),
                            // ),
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.search),
                            ),
                          ),
                        )),
                    const Icon(
                      Bootstrap.sliders,
                      color: main_theme,
                    ),
                  ],
                ),
              ),
          Consumer<Auth>(
            builder: (context, auth, child) {
              return auth.uid !=null ? Expanded(
                child: StreamBuilder(
                  stream: NgoCreatePost().getPosts(auth.uid!),
                  builder: (_, snapshot) {
                    var data = snapshot.data;
                    print('helo');
                    print(data);
                    print(snapshot);
                    if (data == null) {
                      return const Text('No donation available');
                    }
                    return ListView(
                        padding: const EdgeInsets.only(top: 20.0),
                        children: data!
                            .map((post) => donationPostDetails(
                            doner_name: post.userId,
                            post_time: post.datetime,
                            title:
                            'We are an orgnisation os 100+ people and need ${post.quantity}'))
                            .toList());
                  },
                ),
              ) : const SizedBox.shrink();
            },
          ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ngo_createPost(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(225, 255, 255, 255),
          size: 55,
        ),
        backgroundColor: main_theme,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 35,
                color: main_theme,
              ),
              const SizedBox(height: 4),
            ],
          );
        },
        backgroundColor: Colors.white,
        activeIndex: _bottomNavIndex,
        splashColor: Colors.white,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 4,
          spreadRadius: 0.3,
          color: Color.fromARGB(225, 175, 175, 175),
        ),
      ),
    );
  }
}
