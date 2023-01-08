import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter_tutorial/screens/current_location_screen.dart';
import 'package:google_maps_flutter_tutorial/screens/login.dart';
import 'package:google_maps_flutter_tutorial/screens/profile.dart';
import 'package:google_maps_flutter_tutorial/screens/search_places_screen.dart';

import 'nearby_places_screen.dart';

class UserUi extends StatefulWidget {
  const UserUi({Key? key}) : super(key: key);
  @override
  State<UserUi> createState() => _UserUiState();
}

final homeScaffoldKey2 = GlobalKey<ScaffoldState>();

class _UserUiState extends State<UserUi> {
  int _selectedIndex = 0;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      _signOut();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: homeScaffoldKey2,
        appBar: AppBar(
          title: const Text("Welcome User!"),
          centerTitle: true, // this is all you need
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Logout',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.school),
            //   label: 'School',
            // ),
          ],
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              courseLayout(context)
            ],
          ),
        ),
      ),
    );
  }
}

Widget courseLayout(BuildContext context) {
  List<String> imageFileList = [
    'location.png',
    'foodtruck.png',
    'nearby.jpeg',
    'profile.png',
  ];

  List<String> text = [
    'Current Location',
    'Search Foodtruck',
    'Nearby Places',
    'Your Profile',
  ];

  List<Widget> menuList = [
    const CurrentLocationScreen(),
    const SearchPlacesScreen(),
    const NearByPlacesScreen(),
    const Profile()
  ];
  var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
  final double itemWidth = size.width / 2;

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      // childAspectRatio: (itemWidth / itemHeight),
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
    ),
    itemCount: imageFileList.length,
    itemBuilder: (context, index) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return menuList[index];
            }));
          },
          child: Stack(children: <Widget>[
            Image.asset(
              fit: BoxFit.fill,
              'assets/images/${imageFileList[index]}',
            ),
            Container(
                decoration: const BoxDecoration(
              color: Colors.black45,
            )),
            Center(
                child: Text(
              text[index],
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            )),
          ]),
        ),
      );
    },
  );
}
