// To parse this JSON data, do
//
//     final examReq = examReqFromJson(jsonString);

import 'dart:convert';

import '../../../../net/base/forest_cookie.dart';

ExamReq examReqFromJson(String str) => ExamReq.fromJson(json.decode(str));

String examReqToJson(ExamReq data) => json.encode(data.toJson());

class ExamReq {
  ExamReq({
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

  factory ExamReq.fromJson(Map<String, dynamic> json) => ExamReq(
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
