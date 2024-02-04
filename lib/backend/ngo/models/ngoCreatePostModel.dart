//Create model
// To parse this JSON data, do
//
//     final ngoPosts = ngoPostsFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

NgoPosts ngoPostsFromJson(Map<String, dynamic> str) =>
    NgoPosts.fromJson(json.decode(json.encode(str,
        toEncodable: (time) => (time as Timestamp).toDate().toString())));
String ngoPostsToJson(NgoPosts data) => json.encode(data.toJson());

class NgoPosts {
  String? id;
  String userId;
  String location;
  DateTime datetime;
  String quantity;
  List<String> type;
  String msg;

  NgoPosts({
    this.id,
    required this.userId,
    required this.location,
    required this.datetime,
    required this.quantity,
    required this.type,
    required this.msg,
  });

  factory NgoPosts.fromJson(Map<String, dynamic> json) => NgoPosts(
    // id: json["id"],
    userId: json["userId"],
    location: json["location"],
    datetime: DateTime.parse(json["datetime"]),
    quantity: json["quantity"],
    type: List<String>.from(json["type"].map((x) => x)),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    // "id": id,
    "userId": userId,
    "location": location,
    "datetime": datetime,
    "quantity": quantity,
    "type": List<dynamic>.from(type.map((x) => x)),
    "msg": msg,
  };
}