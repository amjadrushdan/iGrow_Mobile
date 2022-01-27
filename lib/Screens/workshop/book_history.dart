import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/nav.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/service/filterscreen.dart';
import 'package:intl/intl.dart';

class HistoryBook extends StatefulWidget {
  String FilterText;

  HistoryBook({required this.FilterText});
  @override
  _HistoryBookState createState() => _HistoryBookState();
}

class _HistoryBookState extends State<HistoryBook> {
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
     
      body: Card(
        child: StreamBuilder<QuerySnapshot>(
          //future: getPosts(),
          stream: workshop,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //var indexLength = snapshot.data.length;
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
                //var data = snapshot.requireData;
                //data = checkIsJoin(data, user);
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data.size,
                  itemBuilder: (BuildContext context, int index) {
                    // var joined = data.docs[index]['joined_uid'];
                    // bool check1 = joined.contains(user!);
                    var state = widget.FilterText;
                    Timestamp timestamp = (data.docs[index]['date']);
                    DateTime now = new DateTime.now();
                    DateTime date = new DateTime(now.year, now.month, now.day);
                    bool check2 = state.contains(data.docs[index]['state']);
                    bool check3 = widget.FilterText.isEmpty;
                    bool check4 = state.contains(data.docs[index]['soil']);
                    bool check5 = timestamp.toDate().isBefore(date);
                    if (((check2 || check4) || check3 )&& check5) {
                      return Card(
                        elevation: 6,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 22,
                            backgroundImage:
                                NetworkImage(data.docs[index]['imageUrl']),
                          ),
                          //title: Text(snapshot.data[index]['programmename']),
                          //subtitle: Text(snapshot.data[index]['date']),
                          title: Text("${data.docs[index]['programmename']}"),
                          subtitle: Text(
                              DateFormat.yMMMMd().format(timestamp.toDate())),
                          //onTap: () => navigateToDetail(snapshot.data[index]),
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
    );
  }
}
