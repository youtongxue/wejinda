import 'dart:convert';

import '../../../../net/forest_cookie.dart';

LoginReqDTO jwwLoginBodyFromJson(String str) =>
    LoginReqDTO.fromJson(json.decode(str));

String jwwLoginBodyToJson(LoginReqDTO data) => json.encode(data.toJson());

// 教务网登陆实体信息类
class LoginReqDTO {
  LoginReqDTO({
    required this.username,
    required this.password,
    required this.viewState,
    required this.cookieList,
  });

  String username;
  String password;
  String viewState;
  List<ForestCookie> cookieList;

  factory LoginReqDTO.fromJson(Map<String, dynamic> json) => LoginReqDTO(
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
