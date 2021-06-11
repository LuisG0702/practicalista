// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  Comment({
    this.postId,
    this.name,
    this.email,
    this.body,
    this.id,
  });

  String postId;
  String name;
  String email;
  String body;
  String id;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        postId: json["postId"].toString(),
        name: json["name"],
        email: json["email"],
        body: json["body"],
        id: json["id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "name": name,
        "email": email,
        "body": body,
//        "id": id,
      };
}
