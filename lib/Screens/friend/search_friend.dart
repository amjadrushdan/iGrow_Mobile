import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/friend/add_info_friend.dart';
import 'package:flutter_auth/constants.dart';

class User {
  final String name;
  final String username;
  final String image;
  bool isFollowedByMe;

  User(this.name, this.username, this.image, this.isFollowedByMe);
}

class SearchFriend extends StatefulWidget {
  const SearchFriend({Key? key}) : super(key: key);

  @override
  _SearchFriendState createState() => _SearchFriendState();
}

class _SearchFriendState extends State<SearchFriend> {
  String _foundedUsers = "";

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   setState(() {
  //     _foundedUsers = _users;
  //   });
  // }

  onSearch(String search) {
    setState(() {
      _foundedUsers = search;
      print(_foundedUsers);
    });
  }

  @override
  Widget build(BuildContext context) {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    final Stream<QuerySnapshot> friend = FirebaseFirestore.instance
        .collection('member')
        .where('userid', isEqualTo: user)
        // .orderBy('id')
        .snapshots();

    final Stream<QuerySnapshot> alluser =
        FirebaseFirestore.instance.collection('member').snapshots();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Container(
          height: 38,
          child: TextField(
            onChanged: (value) => onSearch(value),
            decoration: InputDecoration(
                filled: true,
                fillColor: kBackgroundColor,
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: kDarkGreen,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintStyle: TextStyle(fontSize: 14, color: kDarkGreen),
                hintText: "Search users"),
          ),
        ),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: alluser,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            } else {
              // return Text("Testing ...");
              var data = snapshot.requireData;

              return ListView.builder(
                itemCount: data.size,
                itemBuilder: (BuildContext context, int index) {
                  return StreamBuilder(
                    stream: friend,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot2) {
                      if (snapshot2.hasError) {
                        return Text("something is wrong");
                      }
                      if (snapshot2.connectionState ==
                          ConnectionState.waiting) {
                        return SizedBox.shrink();
                      }
                      if (data.docs[index]['userid'] == user) {
                        return SizedBox.shrink();
                      }

                      var added =
                          snapshot2.data!.docChanges[0].doc['friend_uid'] +
                              snapshot2.data!.docChanges[0].doc['pending_uid'] +
                              snapshot2.data!.docChanges[0].doc['request_uid'];
                      bool check = added.contains(data.docs[index]['userid']);
                      bool check2 = "${data.docs[index]['username']}"
                          .toLowerCase()
                          .contains(_foundedUsers.toLowerCase());
                      print(check2);
                      if (check) {
                        return Card(
                          elevation: 6,
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(
                                  "${data.docs[index]['imageUrl']}"),
                            ),
                            title: Text("${data.docs[index]['username']}"),
                            trailing: Icon(Icons.add),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddInfoFriend(
                                        docid: snapshot.data!.docs[index],
                                        docuser: snapshot2.data!.docs[0]),
                                  ));
                            },
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
