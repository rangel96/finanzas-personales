// To parse this JSON data, do
//
//     final pay = payFromMap(jsonString);

import 'dart:convert';

class TagModel {
  TagModel({
    required this.name,
  });

  String name;

  factory TagModel.fromJson(String str) => TagModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TagModel.fromMap(Map<String, dynamic> json) => TagModel(
        name: json['name'],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
