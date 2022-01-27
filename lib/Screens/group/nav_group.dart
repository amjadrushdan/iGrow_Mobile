import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/group/create_group.dart';
import 'package:flutter_auth/Screens/group/joined_group.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/service/filterscreen.dart';
import 'discover_group.dart';
import 'joined_group.dart';

class GroupNav extends StatefulWidget {
  @override
  _GroupNavState createState() => _GroupNavState();
}

class _GroupNavState extends State<GroupNav> {
  String filterText = "";
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Group",
              style: TextStyle(color: Colors.black),
            ),
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 0, 0),
              child: CircleAvatar(
                // radius: 30,
                backgroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/igrow-kms-e3bec.appspot.com/o/photos%2Ficons8-group-64.png?alt=media&token=6218980a-031d-4595-b96b-899b787826ef"),
              ),
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
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FilterScreen();
                        },
                      ),
                    );

                    setState(
                      () {
                        filterText = "$result";
                      },
                    );
                    print(result);
                  },
                  child: Icon(
                    Icons.filter_alt_sharp,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          // appBar: BaseAppBar(appBar: AppBar(), title: "Group"),

          floatingActionButton: Padding(
            padding:  EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom + 60),
            child: FloatingActionButton.extended(
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
          ),
          body: TabBarView(
            children: [
              GroupDiscover(FilterText: filterText),
              GroupJoined(FilterText: filterText),
            ],
          ),
        ),
      );
}
