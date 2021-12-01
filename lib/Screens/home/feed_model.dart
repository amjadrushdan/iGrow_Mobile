// To parse this JSON data, do
//
//     final feed = feedFromJson(jsonString);

import 'dart:convert';

List<Feed> feedFromJson(String str) =>
    List<Feed>.from(json.decode(str).map((x) => Feed.fromJson(x)));

String feedToJson(List<Feed> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Feed {
  Feed({
    required this.id,
    required this.photo,
    required this.title,
    required this.video,
    required this.message,
    required this.groupId,
    required this.creatorId,
    required this.createdAt,
  });

  int id;
  String photo;
  String title;
  String video;
  String message;
  String groupId;
  String creatorId;
  int createdAt;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["id"],
        photo: json["Photo"],
        title: json["Title"],
        video: json["Video"],
        message: json["Message"],
        groupId: json["Group_id"],
        creatorId: json["Creator_id"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Photo": photo,
        "Title": title,
        "Video": video,
        "Message": message,
        "Group_id": groupId,
        "Creator_id": creatorId,
        "created_at": createdAt,
      };
}
