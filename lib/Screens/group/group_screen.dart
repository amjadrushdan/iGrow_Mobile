import 'package:flutter/material.dart';
import '../../constants.dart';

class Group extends StatelessWidget {
  // Generate some dummy data
  final List dummyList = List.generate(10, (index) {
    return {
      "id": index,
      "title": "Group $index",
      "subtitle": "This is the subtitle group $index"
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView.builder(
      itemCount: dummyList.length,
      itemBuilder: (context, index) => Card(
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(dummyList[index]["id"].toString()),
            backgroundColor: kPrimaryLightColor,
          ),
          title: Text(dummyList[index]["title"]),
          subtitle: Text(dummyList[index]["subtitle"]),
          trailing: Icon(Icons.add),
        ),
      ),
    )));
  }
}
