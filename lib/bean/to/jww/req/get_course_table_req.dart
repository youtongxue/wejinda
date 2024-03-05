// To parse this JSON data, do
//
//     final getCourseTableReq = getCourseTableReqFromJson(jsonString);

import 'dart:convert';

import '../../../../net/base/forest_cookie.dart';

GetCourseTableReq getCourseTableReqFromJson(String str) =>
    GetCourseTableReq.fromJson(json.decode(str));

String getCourseTableReqToJson(GetCourseTableReq data) =>
    json.encode(data.toJson());

class GetCourseTableReq {
  GetCourseTableReq({
    required this.userId,
    required this.username,
    required this.cookieList,
  });

  String userId;
  String username;
  List<ForestCookie> cookieList;

  factory GetCourseTableReq.fromJson(Map<String, dynamic> json) =>
      GetCourseTableReq(
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
