import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/nav.dart';
import 'package:flutter_auth/constants.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  //late Future _data;
  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore.collection('workshop').get();
    return qn.docs;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            "Booked Workshop",
          ),
        ),
        body: Card(
          child: FutureBuilder(
            future: getPosts(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              //var indexLength = snapshot.data.length;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading..."),
                );
              } else {
                return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(snapshot.data[index]['programmename']),
                        subtitle: Text(snapshot.data[index]['date']),
                        onTap: () => navigateToDetail(snapshot.data[index]),
                      );
                    });
              }
            },
          ),
        ));
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post["programmename"]),
        backgroundColor: kPrimaryColor,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Description"),
            subtitle: Text(widget.post["description"]),
          ),
          new Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Date"),
            subtitle: Text(widget.post["date"]),
          ),
          new Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Start Time"),
            subtitle: Text(widget.post["starttime"]),
          ),
          ListTile(
            title: Text("End Time"),
            subtitle: Text(widget.post["endtime"]),
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
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          widget.post.reference.delete().whenComplete(() {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Nav()));
          });
        },
        child: new Icon(Icons.delete),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
