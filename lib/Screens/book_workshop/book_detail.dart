import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';


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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post["programmename"]),
        backgroundColor: kPrimaryColor,
      ),
      body: ListView(

        children: [
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
            subtitle: Text(widget.post["date"]),
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
          const SizedBox(
            height: 280,
          ),
          Container(
              height: 45,
              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: ElevatedButton(
                  style: raisedButtonStyle,
                  child: Text('Apply'),
                  onPressed: () {
                    widget.post.reference.update({
                      'joined_uid': FieldValue.arrayUnion([user]),
                      
                    }).whenComplete(() {
                      Navigator.pop(context);
                    });
                    
                  })),
        ],
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

       
