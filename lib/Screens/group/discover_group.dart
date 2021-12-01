import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'info_group.dart';
import 'group_model.dart';

Future<List<Group>?> getGroup() async {
  final response =
      await http.get(Uri.parse('https://retoolapi.dev/1WVaql/group'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Group.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class GroupDiscover extends StatefulWidget {
  @override
  _GroupDiscoverState createState() => _GroupDiscoverState();
}

class _GroupDiscoverState extends State<GroupDiscover> {
  late Future<List<Group>?> futureGroup;

  @override
  void initState() {
    super.initState();
    futureGroup = getGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Group>?>(
          future: futureGroup,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Group> data = snapshot.data;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) => Card(
                      elevation: 6,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Icon(
                          Icons.camera_alt,
                          size: 40,
                        ),
                        title: Text(data[index].name),
                        subtitle: Text(data[index].id.toString()),
                        trailing: Icon(Icons.add),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => InfoGroupDiscover(group: data[index],)
                            ));
                        },
                      )));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}