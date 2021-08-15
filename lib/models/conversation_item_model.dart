import 'dart:convert';

class ConversationItemModel {
  String? userId;
  String? withUserName;
  String? withUserId;
  String? withRoomId;
  int? numberOfMessages;
  ConversationItemModel({
     this.userId,
     this.withUserName,
     this.withUserId,
     this.withRoomId,
     this.numberOfMessages,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'with_username':withUserName,
      'with_user_id': withUserId,
      'with_room_id': withRoomId,
      'number_of_messages': numberOfMessages,
    };
  }

  factory ConversationItemModel.fromMap(Map<String, dynamic> map) {
    return ConversationItemModel(
      userId: map['user_id'] ?? '',
      withUserName: map['with_username'] ?? '',
      withUserId: map['with_user_id'] ?? '',
      withRoomId: map['with_room_id'] ?? '',
      numberOfMessages: map['number_of_messages'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationItemModel.fromJson(String source) => ConversationItemModel.fromMap(json.decode(source));
}
