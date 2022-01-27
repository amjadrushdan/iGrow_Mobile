import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/friend/info_friend.dart';
import 'package:flutter_auth/constants.dart';

class GroupMember extends StatefulWidget {
  final DocumentSnapshot docid;
  GroupMember({required this.docid});

  // const GroupMember({Key? key, this.group_id}) : super(key: key);

  @override
  _GroupMemberState createState() => _GroupMemberState();
}

class _GroupMemberState extends State<GroupMember> {
  final Stream<QuerySnapshot> alluser =
      FirebaseFirestore.instance.collection('member').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "Group Member",
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
                  var added = widget.docid.get("joined_uid");
                  bool check = added.contains(data.docs[index]['userid']);

                  if (!check) {
                    return SizedBox.shrink();
                  } else {
                    return Card(
                      elevation: 6,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 22,
                          backgroundImage:
                              NetworkImage("${data.docs[index]['imageUrl']}"),
                        ),
                        title: Text("${data.docs[index]['username']}"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InfoFriend(
                                    docid: snapshot.data!.docs[index]),
                              ));
                        },
                      ),
                    );
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
