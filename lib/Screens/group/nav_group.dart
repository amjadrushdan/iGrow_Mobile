import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/group/create_group.dart';
import 'package:flutter_auth/Screens/group/joined_group.dart';
import 'package:flutter_auth/constants.dart';
import 'discover_group.dart';
import 'joined_group.dart';

class GroupNav extends StatefulWidget {
  @override
  _GroupNavState createState() => _GroupNavState();
}

class _GroupNavState extends State<GroupNav> {
  @override

  Widget build(BuildContext context) => DefaultTabController(
    
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Group",
              style: TextStyle(color: Colors.black),
            ),
            leading: Icon(
              Icons.account_circle,
              color: Colors.grey,
              size: 40.0,
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: kPrimaryColor,
              indicatorWeight: 5,
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Discover'),
                Tab(text: 'Joined'),
              ],
            ),
            elevation: 4,
            titleSpacing: 20,
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: kPrimaryColor,
            icon: Icon(Icons.groups),
            label: Text("Create Group"),
            onPressed: () {
              //create group
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateGroup()),
              );
            },
          ),
          body: TabBarView(
            children: [
              GroupDiscover(),
              GroupJoined(),
            ],
          ),
        ),
      );
}
