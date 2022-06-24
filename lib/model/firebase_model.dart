// To parse this JSON data, do
//
//     final fbModel = fbModelFromJson(jsonString);

import 'dart:convert';

FbModel fbModelFromJson(String str) => FbModel.fromJson(json.decode(str));

String fbModelToJson(FbModel data) => json.encode(data.toJson());

class FbModel {
  FbModel({
    this.amount,
    this.email,
    this.name,
    this.number,
    this.userId,
    this.list,
  });

  double amount;
  String email;
  String name;
  String number;
  String userId;
  ListClass list;

  factory FbModel.fromJson(Map<String, dynamic> json) => FbModel(
    amount: json["amount"].toDouble(),
    email: json["email"],
    name: json["name"],
    number: json["number"],
    userId: json["userId"],
    list: ListClass.fromJson(json["list"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "email": email,
    "name": name,
    "number": number,
    "userId": userId,
    "list": list.toJson(),
  };
}

class ListClass {
  ListClass({
    this.amount,
    this.date,
    this.mineId,
    this.tittle,
  });

  int amount;
  String date;
  int mineId;
  String tittle;

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
    amount: json["amount"],
    date: json["date"],
    mineId: json["mineId"],
    tittle: json["tittle"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "date": date,
    "mineId": mineId,
    "tittle": tittle,
  };
}
