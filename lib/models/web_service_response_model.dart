import 'dart:convert';

import 'package:agriunions_logistics/models/pagination_model.dart';

class WebServiceResponse {
  int? status;
  dynamic data;
  dynamic error;
  String? message;
  String? token;
  PaginationModel? pagination;
  WebServiceResponse({
    this.status,
    this.data,
    this.error,
    this.message,
    this.token,
    this.pagination,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data,
      'error': error,
      'message': message,
      'token': token,
      'pagination': pagination?.toMap(),
    };
  }

  factory WebServiceResponse.fromMap(Map<String, dynamic> map) {
    return WebServiceResponse(
      status: map['status'],
      data: map['data'],
      error: map['error'],
      message: map['message'],
      token: map['token'],
      pagination: map['pagination'] != null
          ? PaginationModel.fromMap(map['pagination'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WebServiceResponse.fromJson(String source) =>
      WebServiceResponse.fromMap(json.decode(source));
}
