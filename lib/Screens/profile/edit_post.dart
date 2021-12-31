import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import '../nav.dart';

class editPost extends StatefulWidget {
  DocumentSnapshot docid;
  editPost({required this.docid});

  @override
  _editPostState createState() => _editPostState();
}

class _editPostState extends State<editPost> {
  TextEditingController title = TextEditingController();
  TextEditingController message = TextEditingController();

  @override
  void initState() {
    title = TextEditingController(text: widget.docid.get('title'));
    message = TextEditingController(text: widget.docid.get('message'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Nav()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.post_add,
              color: kPrimaryColor,
              size: 30.0,
            ),
            onPressed: () {
              widget.docid.reference.update({
                'title': title.text,
                'message': message.text,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Nav()));
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: kPrimaryColor,
              size: 30.0,
            ),
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Nav()));
              });
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                    hintText: "Enter your title here"),
                controller: title,
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                    hintText: "Enter your message here"),
                controller: message,
                maxLines: 10,
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     RaisedButton(
          //       onPressed: () {},
          //       color: kPrimaryColor,
          //       padding: EdgeInsets.symmetric(horizontal: 50),
          //       elevation: 2,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20)),
          //       child: Text(
          //         "UPLOAD IMAGE",
          //         style: TextStyle(
          //             fontSize: 14, letterSpacing: 2.2, color: Colors.white),
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
