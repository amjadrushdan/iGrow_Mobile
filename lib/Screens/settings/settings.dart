import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/friend/list_friend.dart';
import 'package:flutter_auth/Screens/friend/pending_friend.dart';
import 'package:flutter_auth/Screens/login/login_screen.dart';
import 'package:flutter_auth/Screens/settings/listFriend.dart';
import 'package:flutter_auth/Screens/workshop/book_nav.dart';
import 'package:flutter_auth/Screens/workshop/book_upcoming.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/Screens/workshop/book_workshop.dart';
import 'package:flutter_auth/service/authentication_service.dart';
import 'edit_profile.dart';

class Settings extends StatelessWidget {


  void _alert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text('Confirm Logout?'),
            actions: [
              TextButton(
                  onPressed: () async {
                   await FireAuth.signOut();
                   
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text('Logout')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'))
            ],
          );
        });
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
        leading: Padding(
          padding: const EdgeInsets.all(7.0),
          child: CircleAvatar(
            // radius: 30,
            backgroundImage: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/igrow-kms-e3bec.appspot.com/o/photos%2Ficons8-settings-50.png?alt=media&token=7222f929-e8ba-4697-b117-94c43c4132e4"),
          ),
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
            color: kBackgroundColor,
            child: Column(
              children: [
                // Profile container ========================================================
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Container(
                          padding: EdgeInsets.only(top: 20),
                          width: double.infinity,
                          height: 130,
                          child: Container(
                              alignment: Alignment(0.0, 0.0),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: kPrimaryColor,
                                child:  CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 500),
                              imageUrl:snapshot.data!.docs[0]['imageUrl'],
                            
                              placeholder: (context, url) => const CircleAvatar(
                                backgroundColor: kDeepGreen,
                                radius: 51,
                              ),
                              imageBuilder: (context, image) => CircleAvatar(
                                backgroundImage: image,
                                radius: 51,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
                                child: InkWell(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Friend Request",
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
                                            .data!.docs[0]['pending_uid'].length
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.0,
                                          //fontWeight: FontWeight.w300
                                        ),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PendingFriend(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: InkWell(
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AllFriends(),
                                      ),
                                    );
                                  },
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
                        color: kPrimaryLightColor,
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
                        color: kPrimaryLightColor,
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
                        color: kPrimaryLightColor,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavBooked()),
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
                                  "Booked",
                                  style: new TextStyle(fontSize: 17.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: kPrimaryLightColor,
                        child: InkWell(
                          onTap: () {
                            _alert(context);
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
