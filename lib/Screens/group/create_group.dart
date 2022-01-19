import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  String name = "";
  String about = "";

  @override
  Widget build(BuildContext context) {
    // final Stream<QuerySnapshot> create = FirebaseFirestore.instance
    //     .collection('group')
    //     .orderBy('id',descending: true).limit(1)
    //     .snapshots();

    // Query createGroup =
    //     FirebaseFirestore.instance.collection('group').orderBy('id',descending: true).limit(1);

    final CollectionReference createGroup =
        FirebaseFirestore.instance.collection('group');
    String? user = FirebaseAuth.instance.currentUser?.uid;
    int? lastID ;
    FirebaseFirestore.instance
        .collection('group')
        .orderBy('id', descending: true)
        .limit(1)
        .get()
        .then((value) {
          print(value.docs[0]['id']);
          lastID = value.docs[0]['id'];
        });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Create Group"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            //group name ===================================================
            Container(
              margin: EdgeInsets.all(15),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  //add prefix icon
                  prefixIcon: Icon(
                    Icons.groups,
                    color: Colors.grey,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "group name",
                  //make hint text
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                  //create lable
                  labelText: 'group name',
                  //lable style
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            //group description ===================================================
            Container(
              margin: EdgeInsets.all(15),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.top,
                maxLines: 5,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (value) {
                  about = value;
                },
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  //add prefix icon
                  prefixIcon: Icon(
                    Icons.description,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "group description",
                  //make hint text
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                  //create lable
                  labelText: 'group description',
                  //lable style
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            //yes button==================================================
            ElevatedButton(
              child: Text(
                "Create group",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                createGroup.add({
                  'about': about,
                  'id': lastID! + 1,
                  'joined_uid': FieldValue.arrayUnion([user]),
                  'name': name,
                  'creator_uid': user,
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
