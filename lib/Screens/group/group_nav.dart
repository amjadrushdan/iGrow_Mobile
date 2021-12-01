import 'package:flutter/material.dart';
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
            //centerTitle: true,
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
                Tab(text: 'Groups'),
              ],
            ),

            elevation: 20,
            titleSpacing: 20,
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