// To parse this JSON data, do
//
//     final scoreTermTimeReq = scoreTermTimeReqFromJson(jsonString);

import 'dart:convert';

import '../../../../net/base/forest_cookie.dart';

ScoreTimeReq scoreTimeReqFromJson(String str) =>
    ScoreTimeReq.fromJson(json.decode(str));

String scoreTimeReqToJson(ScoreTimeReq data) => json.encode(data.toJson());

class ScoreTimeReq {
  ScoreTimeReq({
    required this.userId,
    required this.username,
    required this.cookieList,
  });

  String userId;
  String username;
  List<ForestCookie> cookieList;

  factory ScoreTimeReq.fromJson(Map<String, dynamic> json) => ScoreTimeReq(
        userId: json["userId"],
        username: json["username"],
        cookieList: List<ForestCookie>.from(
            json["cookieList"].map((x) => ForestCookie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "cookieList": List<dynamic>.from(cookieList.map((x) => x.toJson())),
      };
}
