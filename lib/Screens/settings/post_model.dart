import 'package:flutter/cupertino.dart';

class Post {
  final int id;
  final String date;
  final String start_time;
  final String programme_name;
  final String desc;
  final String end_time;
  final String speaker;
  final String pic;

  Post({
    required this.date,
    required this.id,
    required this.programme_name,
    required this.desc,
    required this.start_time,
    required this.end_time,
    required this.speaker,
    required this.pic,
  });

  factory Post.fromjson(Map<String, dynamic> json) {
    return Post(
      date: json['date'] as String,
      id: json['id'] as int,
      programme_name: json['programme_name'] as String,
      desc: json['desc'] as String,
      start_time: json['start_time'] as String,
      end_time: json['end_time'] as String,
      speaker: json['speaker'] as String,
      pic: json['pic'] as String,
    );
  }
}
