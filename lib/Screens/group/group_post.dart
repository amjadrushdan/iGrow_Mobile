import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/storage.dart';
import 'package:flutter_auth/constants.dart';
import '../nav.dart';

class GroupPost extends StatefulWidget {
  final int groupid;
  GroupPost({required this.groupid});

  @override
  _GroupPostState createState() => _GroupPostState();
}

class _GroupPostState extends State<GroupPost> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var title = '';
  var message = '';
  DateTime created_at = new DateTime.now();
  final _formKey = GlobalKey<FormState>();
  File? image;
  late Future imageUrl;
  Storage _storage = new Storage();

  @override
  Widget build(BuildContext context) {
    var group_id = widget.groupid;
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
                'imageUrl': _storage.getUrl(),
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     RaisedButton(
          //       onPressed: () {},
          //       color: kPrimaryColor,
          //       padding: EdgeInsets.symmetric(horizontal: 50),
          //       elevation: 2,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20)),
          //       child: Text(
          //         "UPLOAD IMAGE",
          //         style: TextStyle(
          //             fontSize: 14, letterSpacing: 2.2, color: Colors.white),
          //       ),
          //     )
          //   ],
          // ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 140,
                    width: 180,
                    color: Colors.black12,
                    child: image == null
                        ? Icon(
                            Icons.image,
                            size: 50,
                          )
                        : Image.file(
                            image!,
                            fit: BoxFit.fill,
                          )),
                ElevatedButton(
                  child: Text('Pick Image'),
                  style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                  onPressed: () {
                    _storage.getImage(context).then((file) {
                      setState(() {
                        image = File(file.path);
                        print(file.path);
                      });
                    });
                  },
                ),
                TextButton(
                    onPressed: () {
                      if (image != null)
                        _storage.uploadFile(image!, context);
                      else
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("No Image was selected")));
                    },
                    child: Text(
                      'Upload Image',
                      style: TextStyle(color: kPrimaryColor),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
