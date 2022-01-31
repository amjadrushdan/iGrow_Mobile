import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

import '../nav.dart';

class InfoGroup extends StatefulWidget {
  final DocumentSnapshot docid;
  InfoGroup({required this.docid});

  @override
  State<InfoGroup> createState() => _InfoGroupState();
}

class _InfoGroupState extends State<InfoGroup> {
  String? user = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(widget.docid.get('name')),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      // actions
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        icon: Icon(Icons.group_add_sharp),
        label: Text("Join"),
        onPressed: () {
          _alert(context);
          // Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              errorWidget: (context, url, error) => Icon(Icons.error),
              placeholder: (context, url) => Image(image: AssetImage('assets/images/loading.gif')),
              imageUrl: widget.docid.get("imageUrl"),
              fadeInDuration: Duration(milliseconds: 500),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                children: [
                  Text(
                    "Tags : ",
                    textScaleFactor: 1.2,
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FilterChip(
                        selectedColor: kPrimaryColor,
                        selected: true,
                        label: Text(widget.docid.get('state')),
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: kPrimaryColor,
                        checkmarkColor: Colors.white,
                        onSelected: (bool value) {},
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FilterChip(
                        selectedColor: kPrimaryColor,
                        selected: true,
                        label: Text(widget.docid.get('soil')),
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: kPrimaryColor,
                        checkmarkColor: Colors.white,
                        onSelected: (bool value) {},
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FilterChip(
                        selectedColor: kPrimaryColor,
                        selected: true,
                        label: Text(widget.docid.get('plants')),
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: kPrimaryColor,
                        checkmarkColor: Colors.white,
                        onSelected: (bool value) {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Column(
                children: [
                  ListTile(
                    title: Text("Group Name"),
                    subtitle: Text(widget.docid.get('name')),
                  ),
                  ListTile(
                    title: Text("Description"),
                    subtitle: Text(widget.docid.get('about')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _alert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text('Please Confirm'),
            content: Text('Join group?'),
            actions: [
              TextButton(
                  onPressed: () {
                    widget.docid.reference.update({
                      'joined_uid': FieldValue.arrayUnion([user]),
                    }).whenComplete(() {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => Nav()));
                      // Navigator.pop(context);
                    });
                  },
                  child: Text('Join')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }
}
