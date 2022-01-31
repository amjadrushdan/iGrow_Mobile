import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/service/storage.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/service/validator.dart';
import '../nav.dart';

class Post extends StatefulWidget {
  Post({key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var title = '';
  var message = '';
  var group_id = 0;
  DateTime created_at = new DateTime.now();
  final _formKey = GlobalKey<FormState>();
  File? image;
  late Future imageUrl;
  Storage _storage = new Storage();
  // var intcreated = new DateTime.now().toUtc().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    CollectionReference post = FirebaseFirestore.instance.collection('feed');
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
              post
                  .add({
                    'title': title,
                    'message': message,
                    'group_id': 0,
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
                    return 'Please enter some text';
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
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          ),
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
                        ),
                ),
                ElevatedButton(
                  child: Text('Pick Image'),
                  style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                  onPressed: () {
                    _storage.getImage(context).then((file) {
                      setState(() {
                        image = File(file.path);
                        print(file.path);
                        if (image != null) _storage.uploadFile(image!, context);
                      });
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
