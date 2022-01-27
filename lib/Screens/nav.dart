import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/friend/nav_friend.dart';
import 'package:flutter_auth/Screens/group/nav_group.dart';
import 'package:flutter_auth/Screens/profile/profile_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'Settings/settings.dart';
import 'home/home_screen.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    GroupNav(),
    FriendNav(),
    Profile(),
    Settings(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: bottomNav,
      // BottomNavigationBar(
      //   // backgroundColor: kPrimaryColor,

      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.black,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home,
      //       ),
      //       label: "Home",
      //       backgroundColor: kPrimaryColor,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.group,
      //       ),
      //       label: "Group",
      //       backgroundColor: kPrimaryColor,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.person_add,
      //       ),
      //       label: "Friend",
      //       backgroundColor: kPrimaryColor,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.person,
      //       ),
      //       label: "Profile",
      //       backgroundColor: kPrimaryColor,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.settings,
      //       ),
      //       label: "Settings",
      //       backgroundColor: kPrimaryColor,
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTap,
      //   selectedFontSize: 13.0,
      //   unselectedFontSize: 13.0,
      // ),
    );
  }

  Widget get bottomNav {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
                backgroundColor: kPrimaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.group,
                ),
                label: "Group",
                backgroundColor: kPrimaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_add,
                ),
                label: "Friend",
                backgroundColor: kPrimaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile",
                backgroundColor: kPrimaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: "Settings",
                backgroundColor: kPrimaryColor,
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTap,
            selectedFontSize: 13.0,
            unselectedFontSize: 13.0,
          ),
        ));
  }
}
