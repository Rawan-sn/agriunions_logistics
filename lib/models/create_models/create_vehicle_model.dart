import 'dart:convert';

import '../attachment_model.dart';

class CreateVehicleModel {
  String? userId;
  String? localName;
  String? latinName;
  String? branchId;
  String? classificationId;
  List<Attachment>? attachments;

  CreateVehicleModel({
    this.userId,
    this.localName,
    this.latinName,
    this.branchId,
    this.classificationId,
    this.attachments,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> body = {
      'local_name': localName,
      'latin_name': latinName,
      'branch_id': branchId,
      'classification_id': classificationId,
      'attachments': attachments?.map((x) => x.toMap()).toList() ?? [],
    };
    if(userId!=null) body['user_id'] = userId;
    return body;
  }

  factory CreateVehicleModel.fromMap(Map<String, dynamic> map) {
    return CreateVehicleModel(
      userId: map['user_id'],
      localName: map['local_name'],
      latinName: map['latin_name'],
      branchId: map['branch_id'],
      classificationId: map['classification_id'],
      attachments: List<Attachment>.from(
          map['attachments']?.map((x) => Attachment.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateVehicleModel.fromJson(String source) =>
      CreateVehicleModel.fromMap(json.decode(source));
}
