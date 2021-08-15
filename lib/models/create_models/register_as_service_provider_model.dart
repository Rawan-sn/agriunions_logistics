import 'dart:convert';

import 'package:agriunions_logistics/models/attachment_model.dart';

class RegisterAsServiceProviderModel {
  String? description;
  List<Attachment>? attachments;
  RegisterAsServiceProviderModel({
    this.description,
    this.attachments,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'attachments': attachments?.map((x) => x.toMap()).toList() ?? [],
    };
  }

  factory RegisterAsServiceProviderModel.fromMap(Map<String, dynamic> map) {
    return RegisterAsServiceProviderModel(
      description: map['description'],
      attachments: List<Attachment>.from(
          map['attachments']?.map((x) => Attachment.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterAsServiceProviderModel.fromJson(String source) =>
      RegisterAsServiceProviderModel.fromMap(json.decode(source));
}
