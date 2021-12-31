import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/login/login_screen.dart';
import 'package:flutter_auth/Screens/settings/listPage.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/Screens/book_workshop/book.dart';
import 'edit_profile.dart';

class Settings extends StatelessWidget {
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    late var user = FirebaseAuth.instance.currentUser?.uid;
    final Stream<QuerySnapshot> member = FirebaseFirestore.instance
        .collection('member')
        .where('userid', isEqualTo: user)
        .snapshots();
    return Scaffold(
      body: StreamBuilder(
        stream: member,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
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
                        MaterialPageRoute(
                            builder: (context) =>
                                editProfile(docid: snapshot.data!.docs[0])),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookingPage()),
                      );
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
                        MaterialPageRoute(builder: (context) => ListPage()),
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
          );
        },
      ),
    );
  }
}
