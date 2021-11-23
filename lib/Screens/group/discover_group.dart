import 'package:flutter/material.dart';
import '../../constants.dart';

class Group extends StatefulWidget {
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Card(
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: ListTile(
          leading:Icon(
            Icons.camera_alt,
            size: 40,
          ),
          title: Text("Group name"),
          subtitle: Text("Group description"),
          trailing: Icon(Icons.add),
        ),
      ),
        ),
    );
  }
}