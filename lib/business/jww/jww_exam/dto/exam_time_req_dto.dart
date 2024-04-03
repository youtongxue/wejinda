// To parse this JSON data, do
//
//     final scoreTermTimeReq = scoreTermTimeReqFromJson(jsonString);

import 'dart:convert';

import '../../../../net/forest_cookie.dart';

ExamTimeReqDTO examTimeReqFromJson(String str) =>
    ExamTimeReqDTO.fromJson(json.decode(str));

String examTimeReqToJson(ExamTimeReqDTO data) => json.encode(data.toJson());

class ExamTimeReqDTO {
  ExamTimeReqDTO({
    required this.userId,
    required this.username,
    required this.cookieList,
  });

  String userId;
  String username;
  List<ForestCookie> cookieList;

  factory ExamTimeReqDTO.fromJson(Map<String, dynamic> json) => ExamTimeReqDTO(
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
