import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/group/group_model.dart';
import 'package:flutter_auth/constants.dart';
import 'group_model.dart';

class InfoGroupDiscover extends StatelessWidget {
  final Group group;
 
  InfoGroupDiscover({
    required this.group,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
        backgroundColor: kPrimaryColor,
      ),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
        onPressed: () {},
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("Group Name"),
                  subtitle: Text(group.name),
                ),
                ListTile(
                  title: Text("Description"),
                  subtitle: Text(group.about),
                ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoGroupJoined extends StatelessWidget {
  final Group group;
 
  InfoGroupJoined({
    required this.group,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
        backgroundColor: kPrimaryColor,
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("Group Name"),
                  subtitle: Text(group.name),
                ),
                ListTile(
                  title: Text("Description"),
                  subtitle: Text(group.about),
                ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
