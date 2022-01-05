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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        leading: Icon(
          Icons.settings,
          color: Colors.grey,
          size: 40.0,
        ),
      ),
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
            child: Column(
              children: [
                // Profile container ========================================================
                Container(
                  child: Column(
                    children: [
                      Container(
                        // decoration: BoxDecoration(
                        //     //color: Colors.amber,
                        //     image: DecorationImage(
                        //         image: NetworkImage("add you image URL here "),
                        //         fit: BoxFit.cover)),
                        child: Container(
                          //color: kPrimaryColor,
                          padding: EdgeInsets.only(top: 20),
                          width: double.infinity,
                          height: 130,
                          child: Container(
                              alignment: Alignment(0.0, 0.0),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: kPrimaryColor,
                                child: CircleAvatar(
                                  radius: 51,
                                  backgroundImage: NetworkImage(
                                      'https://i.ibb.co/0ftQ8Zx/icon3.jpg'),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        snapshot.data!.docs[0]['username'],
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapshot.data!.docs[0]['email'],
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Age",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      snapshot.data!.docs[0]['age'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13.0,
                                        //fontWeight: FontWeight.w300
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Friends",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      snapshot
                                          .data!.docs[0]['friend_uid'].length
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13.0,
                                        //fontWeight: FontWeight.w300
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                // Settings container ========================================================
                Container(
                  padding: EdgeInsets.fromLTRB(50, 2, 50, 8),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Card(
                        color: Colors.grey[300],
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => editProfile(
                                      docid: snapshot.data!.docs[0])),
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
                              MaterialPageRoute(
                                  builder: (context) => BookingPage()),
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
                              MaterialPageRoute(
                                  builder: (context) => ListPage()),
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
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
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
                ),
              ],
            ),
          );

          // return
        },
      ),
    );
  }
}
