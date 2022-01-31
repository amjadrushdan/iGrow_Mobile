import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

import '../nav.dart';

class AddInfoFriend extends StatefulWidget {
  final DocumentSnapshot docid;
  final DocumentSnapshot docuser;
  AddInfoFriend({required this.docid, required this.docuser});

  @override
  State<AddInfoFriend> createState() => _AddInfoFriendState();
}

class _AddInfoFriendState extends State<AddInfoFriend> {
  String? user = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.docid.get('username')),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      // actions
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        icon: Icon(Icons.group_add_sharp),
        label: Text("Add Friend"),
        onPressed: () {
          _alert(context);
          // Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                    alignment: Alignment(0.0, 0.0),
                    child: CircleAvatar(
                      radius: 67,
                      backgroundColor: kPrimaryColor,
                      child: CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 500),
                              imageUrl:widget.docid.get('imageUrl'),
                              placeholder: (context, url) => const CircleAvatar(
                                backgroundColor: kDeepGreen,
                                 radius: 63,
                              ),
                              imageBuilder: (context, image) => CircleAvatar(
                                backgroundImage: image,
                                 radius: 63,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                      // CircleAvatar(
                      //   radius: 63,
                      //   backgroundImage:
                      //       NetworkImage(widget.docid.get('imageUrl')),
                      // ),
                    )),
              ),
              ListTile(
                title: Text("Name"),
                subtitle: Text(widget.docid.get('name')),
              ),
              ListTile(
                title: Text("E-mail"),
                subtitle: Text(widget.docid.get('email')),
              ),
              ListTile(
                title: Text("Age"),
                subtitle: Text(widget.docid.get('age')),
              ),
              ListTile(
                title: Text("Gender"),
                subtitle: Text(widget.docid.get('gender')),
              ),
              ListTile(
                title: Text("Marital Status"),
                subtitle: Text(widget.docid.get('maritalstatus')),
              ),
              ListTile(
                title: Text("Occupation"),
                subtitle: Text(widget.docid.get('occupation')),
              ),
              ListTile(
                title: Text("About"),
                subtitle: Text(widget.docid.get('about')),
              ),
            ],
          ),
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
            content: Text('Add friend?'),
            actions: [
              TextButton(
                  onPressed: () {
                    widget.docid.reference.update({
                      'pending_uid': FieldValue.arrayUnion([user]),
                    }).whenComplete(() {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => Nav()));
                      // Navigator.pop(context);
                    });
                    widget.docuser.reference.update({
                      'request_uid':
                          FieldValue.arrayUnion([widget.docid.get('userid')]),
                    }).whenComplete(() {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => Nav()));
                      // Navigator.pop(context);
                    });
                  },
                  child: Text('Add')),
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
