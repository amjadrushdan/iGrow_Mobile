import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/settings/posts.dart';
import 'package:flutter_auth/constants.dart';

import 'edit_profile.dart';

class Settings extends StatelessWidget {
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
              onTap: () {},
              splashColor:kPrimaryColor,
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
              onTap: () {},
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
