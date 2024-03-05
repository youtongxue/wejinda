import 'dart:convert';

import '../../../../net/base/forest_cookie.dart';

LoginReq jwwLoginBodyFromJson(String str) =>
    LoginReq.fromJson(json.decode(str));

String jwwLoginBodyToJson(LoginReq data) => json.encode(data.toJson());

// 教务网登陆实体信息类
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
