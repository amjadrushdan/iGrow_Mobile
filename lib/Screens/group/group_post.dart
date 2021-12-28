import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/service/authentication_service.dart';
import 'package:intl/intl.dart';
import '../nav.dart';

class GroupPost extends StatefulWidget {
  final int groupid;
  GroupPost({required this.groupid});

  @override
  _GroupPostState createState() => _GroupPostState();
}

class _GroupPostState extends State<GroupPost> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var title = '';
    var message = '';
    var group_id = widget.groupid;
    DateTime created_at = new DateTime.now();
    final _formKey = GlobalKey<FormState>();
    // var intcreated = new DateTime.now().toUtc().millisecondsSinceEpoch;
    CollectionReference GroupPost =
        FirebaseFirestore.instance.collection('feed');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Nav()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.post_add,
              color: kPrimaryColor,
              size: 30.0,
            ),
            onPressed: () {
              GroupPost.add({
                'title': title,
                'message': message,
                'group_id': group_id,
                'created_at': created_at,
                // 'intcreated': intcreated,
                'creator_id': auth.currentUser!.uid.toString(),
              })
                  .then((value) => print('feed added')) //feed added
                  .catchError((error) => print('Failed to add feed: $error'));
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => Nav()));
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                    hintText: "Enter your title here"),
                onChanged: (value) {
                  title = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title name is required';
                  }
                  return null;
                },
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                    hintText: "Enter your message here"),
                maxLines: 10,
                onChanged: (value) {
                  message = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Message description is required';
                  }
                  return null;
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () {},
                color: kPrimaryColor,
                padding: EdgeInsets.symmetric(horizontal: 50),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "UPLOAD IMAGE",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
