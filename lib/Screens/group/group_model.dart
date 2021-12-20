import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
    int id;
    String name;
    String about;
    String media;
    String usernameId;
    
    Group({
        required this.id,
        required this.name,
        required this.about,
        required this.media,
        required this.usernameId,
    });

    // factory Group.fromJson(Map<String, dynamic> json) => Group(
    //     id: json["id"],
    //     name: json["Name"],
    //     about: json["About"],
    //     media: json["Media"],
    //     usernameId: json["Username_id"],
    // );

    // factory Group.fromDocumentSnapshot({required DocumentSnapshot<Map<String,dynamic>> doc}){
    //   return Group(
    //     id: doc["id"], 
    //     name: name, 
    //     about: about, 
    //     media: media, 
    //     usernameId: usernameId)
    // }
    
}