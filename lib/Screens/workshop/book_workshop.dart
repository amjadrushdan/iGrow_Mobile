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
  String _foundedWorkshops = "";

  onSearch(String search) {
    setState(() {
      _foundedWorkshops = search;
      print(_foundedWorkshops);
    });
  }

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
      backgroundColor: kBackgroundColor,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 38,
              margin: EdgeInsets.fromLTRB(15, 15, 15, 8),
              child: TextField(
                onChanged: (value) => onSearch(value),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none),
                    hintStyle: TextStyle(fontSize: 14, color: Colors.black),
                    hintText: "Search workshops"),
              ),
            ),
            Container(
              child: StreamBuilder(
                stream: workshop,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final data = snapshot.requireData;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: data.size,
                      itemBuilder: (BuildContext context, index) {
                        var joined = data.docs[index]['joined_uid'];
                        var state = filterText;
                        Timestamp timestamp = (data.docs[index]['date']);
                        DateTime now = new DateTime.now();
                        DateTime date =
                            new DateTime(now.year, now.month, now.day);
                        bool check1 = joined.contains(user!);
                        bool check2 = state.contains(data.docs[index]['state']);
                        bool check3 = filterText.isEmpty;
                        bool check4 = state.contains(data.docs[index]['soil']);
                        bool check5 = timestamp.toDate().isAfter(date);
                        bool check6 = data.docs[index]['programmename']
                            .toLowerCase()
                            .contains(_foundedWorkshops.toLowerCase());

                        if (!check1 &&
                            ((check2 || check4) || check3) &&
                            check5 &&
                            check6) {
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
                              subtitle: Text(DateFormat.yMMMMd()
                                  .format(timestamp.toDate())),
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
          ],
        ),
      ),
    );
  }
}
