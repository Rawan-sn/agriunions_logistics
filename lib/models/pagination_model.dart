import 'dart:convert';

class PaginationModel {
  int? totalItems;
  int? totalPages;
  int? currentPage;
  int? persPage;
  PaginationModel({
    this.totalItems,
    this.totalPages,
    this.currentPage,
    this.persPage,
  });

  Map<String, dynamic> toMap() {
    return {
      'total_items': totalItems,
      'total_pages': totalPages,
      'current_page': currentPage,
      'pers_page': persPage,
    };
  }

  factory PaginationModel.fromMap(Map<String, dynamic> map) {
    return PaginationModel(
      totalItems: map['total_items'],
      totalPages: map['total_pages'],
      currentPage: map['current_page'],
      persPage: map['pers_page'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginationModel.fromJson(String source) =>
      PaginationModel.fromMap(json.decode(source));
}
