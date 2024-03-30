// To parse this JSON data, do
//
//     final jwwLoginFirst = jwwLoginFirstFromJson(jsonString);

import 'dart:convert';

import '../../../../net/forest_cookie.dart';

LoginFirstRecDTO jwwLoginFirstFromJson(String str) =>
    LoginFirstRecDTO.fromJson(json.decode(str));

String jwwLoginFirstToJson(LoginFirstRecDTO data) => json.encode(data.toJson());

class LoginFirstRecDTO {
  LoginFirstRecDTO({
    required this.viewState,
    required this.cookieList,
  });

  String viewState;
  List<ForestCookie> cookieList;

  factory LoginFirstRecDTO.fromJson(Map<String, dynamic> json) =>
      LoginFirstRecDTO(
        viewState: json["viewState"],
        cookieList: List<ForestCookie>.from(
            json["cookieList"].map((x) => ForestCookie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "viewState": viewState,
        "cookieList": List<dynamic>.from(cookieList.map((x) => x.toJson())),
      };
}
