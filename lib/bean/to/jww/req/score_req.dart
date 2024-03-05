// To parse this JSON data, do
//
//     final examReq = examReqFromJson(jsonString);

import 'dart:convert';

import '../../../../net/base/forest_cookie.dart';

ScoreReq scoreReqFromJson(String str) => ScoreReq.fromJson(json.decode(str));

String scoreReqToJson(ScoreReq data) => json.encode(data.toJson());

class ScoreReq {
  ScoreReq({
    required this.userId,
    required this.username,
    required this.xn,
    required this.xq,
    required this.cookieList,
  });

  String userId;
  String username;
  String xn;
  String xq;
  List<ForestCookie> cookieList;

  factory ScoreReq.fromJson(Map<String, dynamic> json) => ScoreReq(
        userId: json["userId"],
        username: json["username"],
        xn: json["xn"],
        xq: json["xq"],
        cookieList: List<ForestCookie>.from(
            json["cookieList"].map((x) => ForestCookie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "xn": xn,
        "xq": xq,
        "cookieList": List<dynamic>.from(cookieList.map((x) => x.toJson())),
      };
}
