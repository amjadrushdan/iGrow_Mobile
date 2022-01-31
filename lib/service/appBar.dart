import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String title;

  // / you can add more fields that meet your needs

  const BaseAppBar({required this.appBar, required this.title});

  @override
  Widget build(BuildContext context) {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    final Stream<QuerySnapshot> member = FirebaseFirestore.instance
        .collection('member')
        .where('userid', isEqualTo: user)
        .snapshots();

    return StreamBuilder(
      stream: member,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return AppBar(
          backgroundColor: Colors.white,
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(7.0),
            child: CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 300),
              imageUrl: snapshot.data?.docs[0]['imageUrl'] ?? "",
              placeholder: (context, url) => const CircleAvatar(
                backgroundColor: kDeepGreen,
              ),
              imageBuilder: (context, image) => CircleAvatar(
                backgroundImage: image,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            // CircleAvatar(
            //   backgroundImage:
            //       NetworkImage(snapshot.data?.docs[0]['imageUrl'] ?? ""),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
