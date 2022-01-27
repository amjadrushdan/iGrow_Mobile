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
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(widget.post["programmename"]),
        backgroundColor: kPrimaryColor,
      ),
      body: ListView(
        children: [
          widget.post["imageUrl"] == ""
                ? Icon(Icons.image)
                : Image.network(
                    widget.post["imageUrl"],
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
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
                        label: Text(widget.post['state']),
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
                        label: Text(widget.post['soil']),
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
                        label: Text(widget.post['plants']),
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
