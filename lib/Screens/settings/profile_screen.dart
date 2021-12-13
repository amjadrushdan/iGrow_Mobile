import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/login/login_screen.dart';
import 'package:flutter_auth/Screens/settings/posts.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/Screens/book_workshop/book.dart';
import 'edit_profile.dart';
import 'package:flutter_auth/service/authentication_service.dart';

class Settings extends StatelessWidget {

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(30.0),
      child: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            color: Colors.grey[300],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsUI()),
                );
              },
              splashColor: kPrimaryColor,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.edit,
                      size: 70.0,
                    ),
                    Text(
                      "Edit Profile",
                      style: new TextStyle(fontSize: 17.0),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: Colors.grey[300],
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Booking()),);
              },
              splashColor: kPrimaryColor,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.assignment,
                      size: 70.0,
                    ),
                    Text(
                      "Book Workshop",
                      style: new TextStyle(fontSize: 17.0),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: Colors.grey[300],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostsPage()),
                );
              },
              splashColor: kPrimaryColor,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today,
                      size: 70.0,
                    ),
                    Text(
                      "Schedule",
                      style: new TextStyle(fontSize: 17.0),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: Colors.grey[300],
            child: InkWell(
              onTap: () {
                _signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              splashColor: kPrimaryColor,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.logout,
                      size: 70.0,
                    ),
                    Text(
                      "Logout",
                      style: new TextStyle(fontSize: 17.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
