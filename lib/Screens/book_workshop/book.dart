import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'book_detail.dart';
import 'package:flutter_auth/constants.dart';

class BookingPage extends StatefulWidget {
  @override
  Booking createState() => Booking();
}

class Booking extends State<BookingPage> {
  // Future getPosts() async {
  //   var firestore = FirebaseFirestore.instance;

  //   QuerySnapshot qn = await firestore.collection('workshop').get();
  //   return qn.docs;
  // }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BookingDetail(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    Stream<QuerySnapshot> workshop =
        FirebaseFirestore.instance.collection('workshop').snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "Booking Workshop",
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: workshop,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final data = snapshot.requireData;
              return ListView.builder(
                itemCount: data.size,
                itemBuilder: (BuildContext context, index) {
                  var joined = data.docs[index]['joined_uid'];
                  bool check = joined.contains(user!);
                  if (!check) {
                    return Card(
                      elevation: 6,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 22,
                          backgroundImage:
                              NetworkImage(data.docs[index]['imageUrl']),
                        ),
                        title: Text(data.docs[index]['programmename']),
                        subtitle: Text(data.docs[index]['date']),
                        onTap: () => navigateToDetail(data.docs[index]),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
