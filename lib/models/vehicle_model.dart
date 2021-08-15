import 'dart:convert';

import 'package:agriunions_logistics/helper/data_store.dart';

class VehicleModel {
  String? id;
  String? number;
  String? localName;
  String? latinName;
  User? user;
  String? name;
  Branch? branch;
  Classification? classification;
  List<String>? attachments;

  VehicleModel({
    this.id,
    this.number,
    this.name,
    this.localName,
    this.latinName,
    this.user,
    this.branch,
    this.classification,
    this.attachments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'local_name': localName,
      'latin_name': latinName,
      'user':user!.toMap(),
      'branch': branch!.toMap(),
      'classification':classification!.toMap(),
      'attachments': attachments,
    };
  }

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    VehicleModel model = VehicleModel(
      id: map['id'],
      number: map['number'],
      localName: map['local_name'],
      latinName: map['latin_name'],
      user: User.fromMap(map['user']),
      branch: Branch.fromMap(map['branch']),
      classification: Classification.fromMap(map['classification']),
      attachments: List<String>.from(map['attachments'] ?? const []),
    );
    if (dataStore.lang == dataStore.localLang) {
      model.name = model.localName;
    } else {
      model.name = model.latinName;
    }
    return model;
  }

  String toJson() => json.encode(toMap());

  factory VehicleModel.fromJson(String source) =>
      VehicleModel.fromMap(json.decode(source));
}

class User {
  String? id;
  String? userName;

  User({
    this.id,
    this.userName,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'username': userName};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    User model = User(
      id: map['id'],
      userName: map['username'],
    );
    return model;
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

class Branch {
  String? id;
  String? localName;
  String? latinName;
  String? name;

  Branch({
    this.id,
    this.localName,
    this.latinName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'local_name': localName,
      'latin_name': latinName,
    };
  }

  factory Branch.fromMap(Map<String, dynamic> map) {
    Branch model = Branch(
      id: map['id'],
      localName: map['local_name'],
      latinName: map['latin_name'],
    );
    if (dataStore.lang == dataStore.localLang) {
      model.name = model.localName;
    } else {
      model.name = model.latinName;
    }
    return model;
  }

  String toJson() => json.encode(toMap());

  factory Branch.fromJson(String source) => Branch.fromMap(json.decode(source));
}

class Classification {
  String? id;
  String? localName;
  String? latinName;
  String? name;

  Classification({
    this.id,
    this.localName,
    this.latinName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'local_name': localName,
      'latin_name': latinName,
    };
  }

  factory Classification.fromMap(Map<String, dynamic> map) {
    Classification model = Classification(
      id: map['id'],
      localName: map['local_name'],
      latinName: map['latin_name'],
    );
    if (dataStore.lang == dataStore.localLang) {
      model.name = model.localName;
    } else {
      model.name = model.latinName;
    }
    return model;
  }

  String toJson() => json.encode(toMap());

  factory Classification.fromJson(String source) =>
      Classification.fromMap(json.decode(source));
}
