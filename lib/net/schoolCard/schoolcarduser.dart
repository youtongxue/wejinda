// To parse this JSON data, do
//
//     final schoolCardUser = schoolCardUserFromJson(jsonString);
import 'dart:convert';

SchoolCardUser schoolCardUserFromJson(String str) =>
    SchoolCardUser.fromJson(json.decode(str));

String schoolCardUserToJson(SchoolCardUser data) => json.encode(data.toJson());

class SchoolCardUser {
  SchoolCardUser({
    required this.username,
    required this.password,
    required this.name,
    required this.userClass,
    required this.state,
    required this.money,
    required this.limitMoney,
  });

  SchoolCardUser.now();

  late String? username;
  late String? password;
  late String name = '';
  late String userClass = '';
  late String state = '';
  late String money = '';
  late String limitMoney = '';

  factory SchoolCardUser.fromJson(Map<String, dynamic> json) => SchoolCardUser(
        username: json["username"],
        password: json["password"],
        name: json["name"],
        userClass: json["userClass"],
        state: json["state"],
        money: json["money"],
        limitMoney: json["limitMoney"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "name": name,
        "userClass": userClass,
        "state": state,
        "money": money,
        "limitMoney": limitMoney,
      };
}
