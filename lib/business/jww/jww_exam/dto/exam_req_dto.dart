// To parse this JSON data, do
//
//     final examReq = examReqFromJson(jsonString);

import 'dart:convert';

import '../../../../net/forest_cookie.dart';

ExamReqDTO examReqFromJson(String str) => ExamReqDTO.fromJson(json.decode(str));

String examReqToJson(ExamReqDTO data) => json.encode(data.toJson());

class ExamReqDTO {
  ExamReqDTO({
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

  factory ExamReqDTO.fromJson(Map<String, dynamic> json) => ExamReqDTO(
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
