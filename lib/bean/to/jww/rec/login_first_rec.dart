// To parse this JSON data, do
//
//     final jwwLoginFirst = jwwLoginFirstFromJson(jsonString);

import 'dart:convert';

import '../../../../net/base/forest_cookie.dart';

LoginFirstRec jwwLoginFirstFromJson(String str) =>
    LoginFirstRec.fromJson(json.decode(str));

String jwwLoginFirstToJson(LoginFirstRec data) => json.encode(data.toJson());

class LoginFirstRec {
  LoginFirstRec({
    required this.viewState,
    required this.cookieList,
  });

  String viewState;
  List<ForestCookie> cookieList;

  factory LoginFirstRec.fromJson(Map<String, dynamic> json) => LoginFirstRec(
        viewState: json["viewState"],
        cookieList: List<ForestCookie>.from(
            json["cookieList"].map((x) => ForestCookie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "viewState": viewState,
        "cookieList": List<dynamic>.from(cookieList.map((x) => x.toJson())),
      };
}
