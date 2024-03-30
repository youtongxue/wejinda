// To parse this JSON data, do
//
//     final examReq = examReqFromJson(jsonString);

import 'dart:convert';

import '../../../../net/forest_cookie.dart';

ScoreReqDTO scoreReqFromJson(String str) =>
    ScoreReqDTO.fromJson(json.decode(str));

String scoreReqToJson(ScoreReqDTO data) => json.encode(data.toJson());

class ScoreReqDTO {
  ScoreReqDTO({
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

  factory ScoreReqDTO.fromJson(Map<String, dynamic> json) => ScoreReqDTO(
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
