import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/service/storage.dart';
import 'package:intl/intl.dart';
import '../nav.dart';

class SetupProfile extends StatefulWidget {
  @override
  _SetupProfileState createState() => _SetupProfileState();
}

class _SetupProfileState extends State<SetupProfile> {
  TextEditingController about = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController maritalstatus = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController username = TextEditingController();
  String? user = FirebaseAuth.instance.currentUser?.uid;
  String? emaill = FirebaseAuth.instance.currentUser?.email;
  late int age;
  File? image;
  late String imageUrl;
  Storage _storage = new Storage();
  DateTime date = DateTime(1900);
  int _value = -1;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text('Are you sure?'),
            content: Text('Do you want to cancel registration?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  FirebaseAuth.instance.currentUser!.delete();
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference setupProfile =
        FirebaseFirestore.instance.collection('member');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        elevation: 1,
        title: Text(
          "Setup Profile",
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: () {
              if (_storage.getUrl() == "") {
                imageUrl =
                    "https://firebasestorage.googleapis.com/v0/b/igrow-kms-e3bec.appspot.com/o/photos%2Fdepositphotos_104564156-stock-illustration-male-user-icon.jpg?alt=media&token=774d6fa7-7340-422e-8e46-defecbeff42a";
              } else
                imageUrl = _storage.getUrl();
              setupProfile.add(
                {
                  'about': about.text,
                  'age': age,
                  'district': district.text,
                  'maritalstatus': maritalstatus.text,
                  'occupation': occupation.text,
                  'state': state.text,
                  'username': username.text,
                  'imageUrl': imageUrl,
                  'pending_uid': FieldValue.arrayUnion([]),
                  'request_uid': FieldValue.arrayUnion([]),
                  'friend_uid': FieldValue.arrayUnion([]),
                  'userid': user,
                  'email': emaill,
                  'name': name.text,
                  'dateofbirth': date,
                  'gender': gender.text,
                },
              ).whenComplete(
                () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Nav(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Container(
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
                                  "https://firebasestorage.googleapis.com/v0/b/igrow-kms-e3bec.appspot.com/o/photos%2Fdepositphotos_104564156-stock-illustration-male-user-icon.jpg?alt=media&token=774d6fa7-7340-422e-8e46-defecbeff42a",
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                  controller: name,
                  decoration: InputDecoration(labelText: "Full Name"),
                ),
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(labelText: "Username"),
                ),
                TextFormField(
                  controller: dateofbirth,
                  decoration: InputDecoration(
                    labelText: "Date of birth",
                    hintText: "Ex. Insert your dob",
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    // DateTime date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100)))!;

                    dateofbirth.text = DateFormat.yMMMMd().format(date);
                    // DateTime dates = date.toIso8601String() as DateTime;
                    age = (DateTime.now().year - date.year);
                  },
                ),
                Row(
                  children: [
                    Radio(
                        value: 1,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = 1;
                            gender.text = "Male";
                          });
                        }),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('Male'),
                    Radio(
                        value: 2,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = 2;
                            gender.text = "Female";
                          });
                        }),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('Female'),
                  ],
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
      ),
    );
  }
}
