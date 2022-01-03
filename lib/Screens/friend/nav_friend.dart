import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/friend/add_friend.dart';
import 'package:flutter_auth/Screens/friend/list_friend.dart';
import 'package:flutter_auth/Screens/friend/pending_friend.dart';
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
            leading: Icon(
              Icons.account_circle,
              color: Colors.grey,
              size: 40.0,
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
