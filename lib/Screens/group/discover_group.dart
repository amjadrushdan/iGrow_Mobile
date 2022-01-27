import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_auth/Screens/group/info_group.dart';
import 'package:flutter_auth/constants.dart';

class GroupDiscover extends StatefulWidget {
  String FilterText;

  GroupDiscover({required this.FilterText});
  @override
  _GroupDiscoverState createState() => _GroupDiscoverState();
}

class _GroupDiscoverState extends State<GroupDiscover> {
  // String filterText = widget.FilterText;
  @override
  Widget build(BuildContext context) {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    final Stream<QuerySnapshot> group = FirebaseFirestore.instance
        .collection('group')
        .orderBy('id')
        .snapshots();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: group,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            } else {
              // return Text("Testing ...");
              var data = snapshot.requireData;
              if (data.docs.isEmpty) {
                return Text(
                  "You have join every group !",
                  textScaleFactor: 1.3,
                );
              } else {
                return ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (BuildContext context, int index) {
                    // print(widget.FilterText);
                    var joined = data.docs[index]['joined_uid'];
                    bool check1 = joined.contains(user!);
                    var state = widget.FilterText;
                    bool check2 = state.contains(data.docs[index]['state']);
                    bool check3 = (widget.FilterText).isEmpty;
                    bool check4 = state.contains(data.docs[index]['soil']);

                    if (!check1 && ((check2 || check4) || check3)) {
                      return Card(
                  
                        elevation: 6,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                         
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 22,
                            backgroundImage:
                                NetworkImage(data.docs[index]['imageUrl']),
                          ),
                          title: Text("${data.docs[index]['name']}"),
                          trailing: Icon(Icons.add),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InfoGroup(
                                      docid: snapshot.data!.docs[index]),
                                ));
                          },
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }

                    // } else
                    //   return SizedBox();
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
