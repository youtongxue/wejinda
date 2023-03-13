// To parse this JSON data, do
//
//     final jwwLoginBody = jwwLoginBodyFromJson(jsonString);

import 'dart:convert';

import '../../base/ForestCookie.dart';

LoginReq jwwLoginBodyFromJson(String str) =>
    LoginReq.fromJson(json.decode(str));

String jwwLoginBodyToJson(LoginReq data) => json.encode(data.toJson());

class LoginReq {
  LoginReq({
    required this.username,
    required this.password,
    required this.viewState,
    required this.cookieList,
  });

  String username;
  String password;
  String viewState;
  List<ForestCookie> cookieList;

  factory LoginReq.fromJson(Map<String, dynamic> json) => LoginReq(
        username: json["username"],
        password: json["password"],
        viewState: json["viewState"],
        cookieList: List<ForestCookie>.from(
            json["cookieList"].map((x) => ForestCookie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "viewState": viewState,
        "cookieList": List<dynamic>.from(cookieList.map((x) => x.toJson())),
      };
}
