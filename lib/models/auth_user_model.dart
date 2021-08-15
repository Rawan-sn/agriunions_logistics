import 'dart:convert';

import 'package:agriunions_logistics/models/user_model.dart';

class AuthUserModel {
  String? token;
  UserModel? user;
  AuthUserModel({
    this.token,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'user': user!.toMap(),
    };
  }

  factory AuthUserModel.fromMap(Map<String, dynamic> map) {
    return AuthUserModel(
      token: map['token'],
      user: UserModel.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUserModel.fromJson(String source) =>
      AuthUserModel.fromMap(json.decode(source));
}
