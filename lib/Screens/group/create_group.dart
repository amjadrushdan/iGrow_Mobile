import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/service/storage.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  String name = "";
  String about = "";
  bool isVisible = false;
  File? image;
  Storage _storage = new Storage();
  String? _selectedState = "Select State";
  List<String> state = [
    "Select State",
    "Kelantan",
    "Johor",
    "Negeri Sembilan",
    "Pulau Pinang",
    "Terengganu",
    "Kedah",
    "Pahang",
    "Sabah",
    "Kuala Lumpur",
    "Perak",
    "Sarawak",
    "Melaka",
    "Perlis",
    "Selangor",
  ];

  String? _selectedSoil = "Select Soil";
  List<String> soil = [
    "Select Soil",
    "Others",
    "Clay",
    "Sandy",
    "Silty",
    "Peaty",
    "Chalky",
    "Loamy",
  ];

  String? _selectedPlants = "Select Plants";
  List<String> plants = [
    "Select Plants",
    "Rose",
    "Lily",
    "Hibiscus",
    "Violet",
    "Ixora",
    "Anthurium",
    "Daisy",
    "Lotus",
    "Canna",
    "Orchid",
    "Jasmine",
    "Tulip",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    final CollectionReference createGroup =
        FirebaseFirestore.instance.collection('group');
    String? user = FirebaseAuth.instance.currentUser?.uid;
    int? lastID;
    FirebaseFirestore.instance
        .collection('group')
        .orderBy('id', descending: true)
        .limit(1)
        .get()
        .then((value) {
      print(value.docs[0]['id']);
      lastID = value.docs[0]['id'];
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Create Group"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            //group name ===================================================
            Container(
              margin: EdgeInsets.all(15),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (value) {
                  name = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  //add prefix icon
                  prefixIcon: Icon(
                    Icons.groups,
                    color: Colors.grey,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "group name",
                  //make hint text
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                  //create lable
                  labelText: 'group name',
                  //lable style
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            //group description ==================================================
            Container(
              margin: EdgeInsets.all(15),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.top,
                maxLines: 5,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (value) {
                  about = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  //add prefix icon
                  prefixIcon: Icon(
                    Icons.description,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "group description",
                  //make hint text
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                  //create lable
                  labelText: 'group description',
                  //lable style
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            //select state , soil and plants
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 6,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0.0),
                    decoration: ShapeDecoration(
                        color: kPrimaryLightColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              style: BorderStyle.solid,
                              color: kPrimaryLightColor),
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        )),
                    child: DropdownButton(
                      hint: Text("Choose state"),
                      value: _selectedState,
                      items: state.map((value) {
                        return DropdownMenuItem(
                          child: new Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedState = newValue;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0.0),
                    decoration: ShapeDecoration(
                        color: kPrimaryLightColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              style: BorderStyle.solid,
                              color: kPrimaryLightColor),
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        )),
                    child: DropdownButton(
                      hint: Text("Choose soil"),
                      value: _selectedSoil,
                      items: soil.map((value) {
                        return DropdownMenuItem(
                          child: new Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSoil = newValue;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0.0),
                    decoration: ShapeDecoration(
                        color: kPrimaryLightColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              style: BorderStyle.solid,
                              color: kPrimaryLightColor),
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        )),
                    child: DropdownButton(
                      hint: Text("Choose plants"),
                      value: _selectedPlants,
                      items: plants.map((value) {
                        return DropdownMenuItem(
                          child: new Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPlants = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            //image=======================================================
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 140,
                      width: 180,
                      color: Colors.black12,
                      child: image == null
                          ? Icon(
                              Icons.image,
                              size: 50,
                            )
                          : Image.file(
                              image!,
                              fit: BoxFit.fill,
                            )),
                  ElevatedButton(
                    child: Text('Pick Image'),
                    style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                    onPressed: () {
                      _storage.getImage(context).then((file) {
                        setState(() {
                          image = File(file.path);
                          print(file.path);
                        });
                      });
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        if (image != null) {
                          setState(() {
                            isVisible = true;
                          });

                          _storage.uploadFile(image!, context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("No Image was selected")));
                        }
                      },
                      child: Text(
                        'Upload Image',
                        style: TextStyle(color: kPrimaryColor),
                      ))
                ],
              ),
            ),

            //yes button==================================================
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton.extended(
          icon: Icon(Icons.group_add, color: Colors.black),
          backgroundColor: kPrimaryLightColor,
          label: Text(
            "Create group",
            style: TextStyle(fontSize: 15, color: kPrimaryColor),
          ),
          onPressed: () {
            if (name == "") {
              _alert(context, "Please enter group name");
            } else if (about == "") {
              _alert(context, "Please enter group description");
            } else if (_selectedSoil == "Select Soil" ||
                _selectedState == "Select State" ||
                _selectedPlants == "Select Plants") {
              _alert(context, "Please select the tags");
            } else {
              createGroup.add(
                {
                  'about': about,
                  'id': lastID! + 1,
                  'imageUrl': _storage.getUrl(),
                  'joined_uid': FieldValue.arrayUnion([user]),
                  'name': name,
                  'creator_uid': user,
                  'soil': _selectedSoil,
                  'state': _selectedState,
                  'plants': _selectedPlants,
                },
              );
              Navigator.pop(context);
            }
          },
          // style: ElevatedButton.styleFrom(
          //   primary: kPrimaryColor,
          // ),
        ),
      ),
    );
  }

  void _alert(BuildContext context, String errorType) {
    showDialog(
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Error"),
            content: Text(errorType),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    textScaleFactor: 1.3,
                    textAlign: TextAlign.center,
                  ))
            ],
          );
        });
  }
}
