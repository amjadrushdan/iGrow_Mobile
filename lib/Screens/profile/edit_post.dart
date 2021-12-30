import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

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
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.post_add,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              widget.docid.reference.update({
                'title': title.text,
                'message': message.text,
              }).whenComplete(() {
                Navigator.pop(context);
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pop(context);
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
        ],
      ),
    );
  }
}
