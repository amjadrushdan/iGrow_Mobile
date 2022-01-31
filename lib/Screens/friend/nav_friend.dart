import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/friend/add_friend.dart';
import 'package:flutter_auth/Screens/friend/list_friend.dart';
import 'package:flutter_auth/Screens/friend/pending_friend.dart';
import 'package:flutter_auth/Screens/friend/search_friend.dart';
import 'package:flutter_auth/constants.dart';

class FriendNav extends StatefulWidget {
  @override
  _FriendNavState createState() => _FriendNavState();
}

class _FriendNavState extends State<FriendNav> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Friend",
              style: TextStyle(color: Colors.black),
            ),
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 0, 0),
              child: CircleAvatar(
                // radius: 30,
                backgroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/igrow-kms-e3bec.appspot.com/o/photos%2Ficons8-friend-64.png?alt=media&token=a6e8cdc6-2325-4e65-aa31-672620fd2af0"),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PendingFriend(),
                        ));
                  },
                  child: Icon(
                    Icons.notification_add,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: kPrimaryColor,
              indicatorWeight: 5,
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Find Friend'),
                Tab(text: 'Friend List'),
              ],
            ),
            elevation: 4,
            titleSpacing: 20,
          ),
          body: TabBarView(
            children: [
              AddFriend(),
              ListFriend(),
            ],
          ),
        ),
      );
}
