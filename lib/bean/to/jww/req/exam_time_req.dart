// To parse this JSON data, do
//
//     final scoreTermTimeReq = scoreTermTimeReqFromJson(jsonString);

import 'dart:convert';

import '../../../../net/base/forest_cookie.dart';

ExamTimeReq examTimeReqFromJson(String str) =>
    ExamTimeReq.fromJson(json.decode(str));

String examTimeReqToJson(ExamTimeReq data) => json.encode(data.toJson());

class ExamTimeReq {
  ExamTimeReq({
    required this.userId,
    required this.username,
    required this.cookieList,
  });

  String userId;
  String username;
  List<ForestCookie> cookieList;

  factory ExamTimeReq.fromJson(Map<String, dynamic> json) => ExamTimeReq(
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
