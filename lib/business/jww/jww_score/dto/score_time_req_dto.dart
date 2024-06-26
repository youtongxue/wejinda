// To parse this JSON data, do
//
//     final scoreTermTimeReq = scoreTermTimeReqFromJson(jsonString);

import 'dart:convert';

import '../../../../net/forest_cookie.dart';

ScoreTimeReqDTO scoreTimeReqFromJson(String str) =>
    ScoreTimeReqDTO.fromJson(json.decode(str));

String scoreTimeReqToJson(ScoreTimeReqDTO data) => json.encode(data.toJson());

class ScoreTimeReqDTO {
  ScoreTimeReqDTO({
    required this.userId,
    required this.username,
    required this.cookieList,
  });

  String userId;
  String username;
  List<ForestCookie> cookieList;

  factory ScoreTimeReqDTO.fromJson(Map<String, dynamic> json) =>
      ScoreTimeReqDTO(
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
