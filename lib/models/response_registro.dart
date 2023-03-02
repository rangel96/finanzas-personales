// To parse this JSON data, do
//
//     final registroResponse = registroResponseFromMap(jsonString);

import 'dart:convert';

class RegistroModel {
  RegistroModel({
    this.amount,
    this.description,
    this.fechaC,
    this.id,
    this.pay,
    this.tag,
    this.title,
  });

  double? amount;
  String? description;
  DateTime? fechaC;
  String? id;
  String? pay;
  String? tag;
  String? title;

  factory RegistroModel.fromJson(String str) =>
      RegistroModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegistroModel.fromMap(Map<String, dynamic> json) => RegistroModel(
        amount: json["amount"].toDouble(),
        description: json["description"],
        fechaC: (json["fechaC"]).toDate(),
        id: json["id"],
        pay: json["pay"],
        tag: json["tag"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "description": description,
        "fechaC": fechaC,
        "pay": pay,
        "tag": tag,
        "title": title,
      };

  RegistroModel copy() => RegistroModel(
        amount: amount,
        description: description,
        fechaC: fechaC,
        id: id,
        pay: pay,
        tag: tag,
        title: title,
      );
}
