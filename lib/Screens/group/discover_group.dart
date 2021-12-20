import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'info_group.dart';
import 'group_model.dart';

// Future<List<Group>?> getGroup() async {
//   final response =
//       await http.get(Uri.parse('https://retoolapi.dev/1WVaql/group'));

//   if (response.statusCode == 200) {
//     List jsonResponse = json.decode(response.body);
//     return jsonResponse.map((data) => new Group.fromJson(data)).toList();
//   } else {
//     throw Exception('Unexpected error occured!');
//   }
// }

final _fireStore = FirebaseFirestore.instance;
final _fireAuth = FirebaseAuth.instance.currentUser;

class GroupDiscover extends StatefulWidget {
  @override
  _GroupDiscoverState createState() => _GroupDiscoverState();
}

class _GroupDiscoverState extends State<GroupDiscover> {
  // late Future<List<Group>?> futureGroup;

  // @override
  // void initState() {
  //   super.initState();
  //   futureGroup = getGroup();
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return Scaffold(
        // body: Center(
        //   child: FutureBuilder<List<Group>?>(
        //     future: futureGroup,
        //     builder: (context, AsyncSnapshot snapshot) {
        //       if (snapshot.hasData) {
        //         List<Group> data = snapshot.data;
        //         return ListView.builder(
        //             itemCount: data.length,
        //             itemBuilder: (BuildContext context, int index) => Card(
        //                 elevation: 6,
        //                 margin: EdgeInsets.all(10),
        //                 child: ListTile(
        //                   leading: Icon(
        //                     Icons.camera_alt,
        //                     size: 40,
        //                   ),
        //                   title: Text(data[index].name),
        //                   subtitle: Text(data[index].id.toString()),
        //                   trailing: Icon(Icons.add),
        //                   onTap: () {
        //                     Navigator.push(context, MaterialPageRoute(
        //                       builder: (context) => InfoGroupDiscover(group: data[index],)
        //                       ));
        //                   },
        //                 )));
        //       } else if (snapshot.hasError) {
        //         return Text('${snapshot.error}');
        //       }

        //       return const CircularProgressIndicator();
        //     },
        //   ),
        // ),
        // body: StreamBuilder(
        //   stream: FirebaseFirestore.instance.collection('group').snapshots(),
        //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (!snapshot.hasData) return Text("Loading data...");

        //     return ListView.builder(
        //         itemBuilder: (context, index) => Card(
        //               elevation: 6,
        //               margin: EdgeInsets.all(10),
        //               child: ListTile(
        //                 leading: Icon(
        //                   Icons.camera_alt,
        //                   size: 40,
        //                 ),
        //                 title: Text(data[index].name),
        //                 subtitle: Text(data[index].id.toString()),
        //                 trailing: Icon(Icons.add),
        //               ),
        //             ));
        //   },
        // ),
        body: Center(

      // child :FutureBuilder(
      //   future: _fireStore.collection('group').get(),
      //   builder: (context, snapshot) {
      //     DocumentSnapshot? document = snapshot.data as DocumentSnapshot;
      //     if (!snapshot.hasData)
      //     return Center(
      //       child: const CircularProgressIndicator(),
      //     );

      //     return ListView.builder(itemBuilder: (context, index) {

      //       return ListTile(
      //         leading: const Icon(Icons.group),
      //         title: Text((document.data()! as dynamic) ['name']),
      //         trailing: Icon(Icons.add),
      //       );
      //     });
      //   },
      // ),


      child: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('group').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return Center(
              child: const CircularProgressIndicator(),
            );
          }
          else
            return Text("Testing ...");
        },
      )
      ),
    );
  }
}
