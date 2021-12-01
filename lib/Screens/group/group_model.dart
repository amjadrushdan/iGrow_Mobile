// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'dart:convert';

List<Group> groupFromJson(String str) => List<Group>.from(json.decode(str).map((x) => Group.fromJson(x)));

String groupToJson(List<Group> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Group {
    Group({
        required this.id,
        required this.name,
        required this.about,
        required this.media,
        required this.usernameId,
    });

    int id;
    String name;
    String about;
    String media;
    String usernameId;

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["Name"],
        about: json["About"],
        media: json["Media"],
        usernameId: json["Username_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "About": about,
        "Media": media,
        "Username_id": usernameId,
    };
}