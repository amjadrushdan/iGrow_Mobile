import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:intl/intl.dart';

class BookingDetail extends StatefulWidget {
  final DocumentSnapshot post;
  BookingDetail({required this.post});

  @override
  BookingInfo createState() => BookingInfo();
}

class BookingInfo extends State<BookingDetail> {
  @override
  Widget build(BuildContext context) {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    Timestamp timestamp = (widget.post['date']);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post["programmename"]),
        backgroundColor: kPrimaryColor,
      ),
      body: ListView(
        children: [
          Image.network(widget.post["imageUrl"]),
          ListTile(
            title: Text("Speaker"),
            subtitle: Text(widget.post["speaker"]),
          ),
          ListTile(
            title: Text("Person in Charge"),
            subtitle: Text(widget.post["PIC"]),
          ),
          ListTile(
            title: Text("Date"),
            subtitle: Text(DateFormat.yMMMMd().format(timestamp.toDate())),
          ),
          ListTile(
            title: Text("Time"),
            subtitle:
                Text(widget.post["starttime"] + " - " + widget.post["endtime"]),
          ),
          ListTile(
            title: Text("Description"),
            subtitle: Text(widget.post["description"]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        icon: Icon(Icons.addchart_sharp),
        label: Text("Apply"),
        onPressed: () {
          //create group
          widget.post.reference.update({
            'joined_uid': FieldValue.arrayUnion([user]),
          }).whenComplete(() {
            Navigator.pop(context);
          });
        },
      ),
    );
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: kPrimaryColor,
  minimumSize: const Size(40, 40),
  padding: const EdgeInsets.symmetric(horizontal: 40),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
  ),
);
