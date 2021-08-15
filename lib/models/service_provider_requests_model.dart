import 'dart:convert';

class ProviderRequestsModel {
  String? description;
  String? status;
  String? createdAt;
  List<String>? attachments;

  ProviderRequestsModel({
    this.description,
    this.status,
    this.createdAt,
    this.attachments,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'status': status,
      'created_at': createdAt,
      'attachments': attachments,
    };
  }

  factory ProviderRequestsModel.fromMap(Map<String, dynamic> map) {
    return ProviderRequestsModel(
      description: map['description'],
      status: map['status'],
      createdAt: map['created_at'],
      attachments: List<String>.from(map['attachments'] ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProviderRequestsModel.fromJson(String source) =>
      ProviderRequestsModel.fromMap(json.decode(source));
}

