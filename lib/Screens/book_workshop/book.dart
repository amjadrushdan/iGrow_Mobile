import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_auth/service/filterscreen.dart';
import 'package:intl/intl.dart';
import 'book_detail.dart';
import 'package:flutter_auth/constants.dart';

class BookingPage extends StatefulWidget {
  @override
  Booking createState() => Booking();
}

class Booking extends State<BookingPage> {
  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BookingDetail(post: post)));
  }

  String filterText = "";
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return FilterScreen();
                    },
                  ),
                );

                setState(
                  () {
                    filterText = "$result";
                  },
                );
                print(result);
              },
              child: Icon(
                Icons.filter_alt_sharp,
              ),
            ),
          ),
        ],
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
                  // print(filterText);
                  var joined = data.docs[index]['joined_uid'];
                  bool check1 = joined.contains(user!);
                  var state = filterText;
                  bool check2 = state.contains(data.docs[index]['state']);
                  bool check3 = filterText.isEmpty;
                  bool check4 = state.contains(data.docs[index]['soil']);

                  // DateTime now = new DateTime.now();
                  // DateTime date = new DateTime(now.year, now.month, now.day);
                  // String currentDate = date.day.toString()+" "+DateFormat.LLLL().format(date)+" "+date.year.toString();
                  // bool check5 =  (data.docs[index]["date"] < currentDate);
                  
                  if (!check1 && ((check2 || check4) || check3 )) {
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
