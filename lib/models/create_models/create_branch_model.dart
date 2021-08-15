import 'dart:convert';

class CreateBranchModel {
  String? localName;
  String? latinName;
  String? countryId;

  CreateBranchModel({
    this.localName,
    this.latinName,
    this.countryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'local_name': localName,
      'latin_name': latinName,
      'country_id': countryId,

    };
  }

  factory CreateBranchModel.fromMap(Map<String, dynamic> map) {
    return CreateBranchModel(
      localName: map['local_name'],
      latinName: map['latin_name'],
      countryId: map['country_id']
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateBranchModel.fromJson(String source) =>
      CreateBranchModel.fromMap(json.decode(source));
}
