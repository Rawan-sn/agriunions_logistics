import 'dart:convert';

class SubUserModel {
  String? id;
  String? username;
  SubUserModel({
    this.id,
    this.username,
  });



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
    };
  }

  factory SubUserModel.fromMap(Map<String, dynamic> map) {
    return SubUserModel(
      id: map['id'],
      username: map['username'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubUserModel.fromJson(String source) => SubUserModel.fromMap(json.decode(source));
}
