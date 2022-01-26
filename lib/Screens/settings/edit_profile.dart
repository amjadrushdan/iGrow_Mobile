import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/service/storage.dart';

import '../nav.dart';

class editProfile extends StatefulWidget {
  DocumentSnapshot docid;
  editProfile({required this.docid});

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  TextEditingController about = TextEditingController();
  TextEditingController age = TextEditingController();
  // TextEditingController dateofbirth = TextEditingController();
  TextEditingController district = TextEditingController();
  // TextEditingController email = TextEditingController();
  // TextEditingController gender = TextEditingController();
  TextEditingController maritalstatus = TextEditingController();
  // TextEditingController name = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController username = TextEditingController();
  File? image;
  late String imageUrl;
  Storage _storage = new Storage();

  @override
  void initState() {
    about = TextEditingController(text: widget.docid.get('about'));
    age = TextEditingController(text: widget.docid.get('age').toString());
    district = TextEditingController(text: widget.docid.get('district'));
    maritalstatus =
        TextEditingController(text: widget.docid.get('maritalstatus'));
    occupation = TextEditingController(text: widget.docid.get('occupation'));
    state = TextEditingController(text: widget.docid.get('state'));
    username = TextEditingController(text: widget.docid.get('username'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 1,
        title: Text(
          "Edit Profile",
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () {
                if (_storage.getUrl() == "") {
                  imageUrl = widget.docid.get('imageUrl');
                } else
                  imageUrl = _storage.getUrl();
                widget.docid.reference.update({
                  'about': about.text,
                  'age': age.text,
                  'district': district.text,
                  'maritalstatus': maritalstatus.text,
                  'occupation': occupation.text,
                  'state': state.text,
                  'username': username.text,
                  'imageUrl': imageUrl,
                }).whenComplete(() {
                  Navigator.pop(context);
                });
              }),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: image == null
                          ? ClipOval(
                              child: Image.network(
                                widget.docid.get('imageUrl'),
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipOval(
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          _storage.getImage(context).then((file) {
                            setState(() {
                              image = File(file.path);
                              print(file.path);
                              if (image != null)
                                _storage.uploadFile(image!, context);
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextFormField(
                controller: username,
                decoration: InputDecoration(labelText: "Username"),
              ),
              TextFormField(
                controller: age,
                decoration: InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
              TextFormField(
                controller: state,
                decoration: InputDecoration(labelText: "State"),
              ),
              TextFormField(
                controller: district,
                decoration: InputDecoration(labelText: "District"),
              ),
              TextFormField(
                controller: occupation,
                decoration: InputDecoration(labelText: "Occupation"),
              ),
              TextFormField(
                controller: maritalstatus,
                decoration: InputDecoration(labelText: "Marital Status"),
              ),
              TextFormField(
                controller: about,
                decoration: InputDecoration(labelText: "About"),
                maxLines: null,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
