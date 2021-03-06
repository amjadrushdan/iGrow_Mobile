import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/nav.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/service/filterscreen.dart';
import 'package:intl/intl.dart';

class ListPage extends StatefulWidget {
  String FilterText;

  ListPage({required this.FilterText});
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String _foundedWorkshops = "";

  onSearch(String search) {
    setState(() {
      _foundedWorkshops = search;
      print(_foundedWorkshops);
    });
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    Stream<QuerySnapshot> workshop = FirebaseFirestore.instance
        .collection('workshop')
        .where(
          "joined_uid",
          arrayContains: user,
        )
        .snapshots();
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
              child: StreamBuilder<QuerySnapshot>(
                stream: workshop,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Loading..."),
                    );
                  } else {
                    final data = snapshot.requireData;
                    if (data.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "You have not book any workshop !",
                          textScaleFactor: 1.3,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: data.size,
                        itemBuilder: (BuildContext context, int index) {
                          var state = widget.FilterText;
                          Timestamp timestamp = (data.docs[index]['date']);
                          DateTime now = new DateTime.now();
                          DateTime date =
                              new DateTime(now.year, now.month, now.day);
                          bool check2 =
                              state.contains(data.docs[index]['state']);
                          bool check3 = widget.FilterText.isEmpty;
                          bool check4 =
                              state.contains(data.docs[index]['soil']);
                          bool check5 = timestamp.toDate().isAfter(date);
                          bool check6 = data.docs[index]['programmename']
                              .toLowerCase()
                              .contains(_foundedWorkshops.toLowerCase());

                          if (((check2 || check4) || check3) &&
                              check5 &&
                              check6) {
                            return Card(
                              elevation: 6,
                              margin: EdgeInsets.all(10),
                              child: ListTile(
                                leading: CachedNetworkImage(
                            fadeInDuration: Duration(milliseconds: 500),
                            imageUrl: data.docs[index]['imageUrl'],
                            placeholder: (context, url) => const CircleAvatar(
                              backgroundColor: kDeepGreen,
                              radius: 22,
                            ),
                            imageBuilder: (context, image) => CircleAvatar(
                              backgroundImage: image,
                              radius: 22,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                                title: Text(
                                    "${data.docs[index]['programmename']}"),
                                subtitle: Text(DateFormat.yMMMMd()
                                    .format(timestamp.toDate())),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                              post: snapshot.data!.docs[index],
                                            )),
                                  );
                                },
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  QuerySnapshot<Object?> checkIsJoin(
      QuerySnapshot<Object?> data, String? user) {
    data.docs.remove(user);
    return data;
  }
}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  DetailPage({required this.post});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = (widget.post['date']);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post["programmename"]),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.post["imageUrl"],
              fit: BoxFit.fitWidth,
              width: double.infinity,
              placeholder: (context, url) =>
                  Image(image: AssetImage('assets/images/loading.gif')),
              errorWidget: (context, url, error) => Icon(Icons.error),
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
              title: Text("Description"),
              subtitle: Text(widget.post["description"]),
            ),
            new Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text("Date"),
              subtitle: Text(DateFormat.yMMMMd().format(timestamp.toDate())),
            ),
            new Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text("Time"),
              subtitle: Text(
                  widget.post["starttime"] + " - " + widget.post["endtime"]),
            ),
            new Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text("Person In Charge"),
              subtitle: Text(widget.post["PIC"]),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text("Speaker"),
              subtitle: Text(widget.post["speaker"]),
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        icon: Icon(Icons.delete),
        label: Text("Delete"),
        onPressed: () {
          //create group
          deleteJoin(context);
        },
      ),
    );
  }

  Future deleteJoined(context) async {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    Stream<QuerySnapshot> workshop = FirebaseFirestore.instance
        .collection('workshop')
        .doc('uid')
        .collection("join_workshop")
        .snapshots();

    //return await doc.delete();
  }

  void deleteJoin(BuildContext context) {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    Stream<QuerySnapshot> workshop = FirebaseFirestore.instance
        .collection('workshop')
        .doc('uid')
        .collection("join_workshop")
        .snapshots();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Please confirm"),
            content: Text("Sure to cancel booking?"),
            actions: [
              TextButton(
                  onPressed: () {
                    widget.post.reference.update({
                      'joined_uid': FieldValue.arrayRemove([user]),
                    }).whenComplete(() => Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => Nav())));
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          );
        });
  }
}
