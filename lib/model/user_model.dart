import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconify_flutter/icons/heroicons_outline.dart';

class User {
  final String? userID;
  final String? name;
  final String? emailAddress;
  final String? contact;

  User({
    this.userID,
    this.name,
    this.emailAddress,
    this.contact,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['user_id'],
      name: json["name"],
      emailAddress: json["email"],
      contact: json["contact"],
    );
  }

  Map<String, dynamic> toJson() => {
        'userID': userID.toString(),
        'name': name,
        'emailAddress': emailAddress,

  };
}
