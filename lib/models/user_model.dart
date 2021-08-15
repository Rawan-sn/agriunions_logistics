import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? mobile;
  bool? isServiceProvider;
  String? masterUserId;
  bool? online;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.isServiceProvider,
    this.masterUserId,
    this.online,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': name,
      'email': email,
      'mobile': mobile,
      'is_service_provider': isServiceProvider,
      'master_user_id': masterUserId,
      'online': online,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['username'],
      email: map['email'],
      mobile: map['mobile'],
      isServiceProvider: map['is_service_provider'],
      masterUserId: map['master_user_id'],
      online: map['online'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
