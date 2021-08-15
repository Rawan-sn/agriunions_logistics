import 'dart:convert';

class ChatItemModel {
  String? userId;
  String? userName;
  String? toUserId;
  String? toUserName;
  String? toRoomId;
  String? message;
  List<String>? attachments;
  ChatItemModel({
     this.userId,
     this.userName,
     this.toUserId,
     this.toUserName,
     this.toRoomId,
     this.message,
     this.attachments,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'username':userName,
      'to_user_id': toUserId,
      'to_username':toUserName,
      'to_room_id': toRoomId,
      'message': message,
      'attachments': attachments,
    };
  }

  factory ChatItemModel.fromMap(Map<String, dynamic> map) {
    return ChatItemModel(
      userId: map['user_id'] ?? '',
      userName: map['username'] ?? '',
      toUserId: map['to_user_id'] ?? '',
      toUserName:map['to_username'] ?? '',
      toRoomId: map['to_room_id'] ?? '',
      message: map['message'] ?? "",
      attachments: List<String>.from(map['attachments'] ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatItemModel.fromJson(String source) => ChatItemModel.fromMap(json.decode(source));
}
