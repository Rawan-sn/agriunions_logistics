import 'dart:convert';

class LinkRequestModel {
  String? id;
  String? userId;
  String? masterUserId;
  String? status;
  String? username;
  String? masterUserName;
  String? currentMasterUserId;
  String? currentMasterUserName;

  LinkRequestModel({
    this.id,
    this.userId,
    this.masterUserId,
    this.status,
    this.username,
    this.masterUserName,
    this.currentMasterUserId,
    this.currentMasterUserName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'master_user_id': masterUserId,
      'status': status,
      'username': username,
      'master_username': masterUserName,
      'current_master_user_id': currentMasterUserId,
      'current_master_user_name': currentMasterUserName,
    };
  }

  factory LinkRequestModel.fromMap(Map<String, dynamic> map) {
    return LinkRequestModel(
      id: map['id'],
      userId: map['user_id'],
      masterUserId: map['master_user_id'],
      status: map['status'],
      username: map['username'],
      masterUserName: map['master_username'],
      currentMasterUserId: map['current_master_user_id'],
      currentMasterUserName: map['current_master_user_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LinkRequestModel.fromJson(String source) =>
      LinkRequestModel.fromMap(json.decode(source));
}
