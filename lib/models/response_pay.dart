// To parse this JSON data, do
//
//     final pay = payFromMap(jsonString);

import 'dart:convert';

class PayModel {
  PayModel({
    required this.name,
  });

  String name;

  factory PayModel.fromJson(String str) => PayModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PayModel.fromMap(Map<String, dynamic> json) => PayModel(
        name: json['name'],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
