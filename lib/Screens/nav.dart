import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/profile/profile_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'group/group_screen.dart';
import 'home/home_screen.dart';
import 'message/message_screen.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Group(),
    Message(),
    Profile(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              'Home',
            ),
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
            ),
            title: Text(
              'Group',
            ),
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
            ),
            title: Text(
              'Messages',
            ),
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text(
              'Profile',
            ),
            backgroundColor: kPrimaryColor,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}
