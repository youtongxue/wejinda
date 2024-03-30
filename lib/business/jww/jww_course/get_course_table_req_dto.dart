// To parse this JSON data, do
//
//     final getCourseTableReq = getCourseTableReqFromJson(jsonString);

import 'dart:convert';

import '../../../net/forest_cookie.dart';

GetCourseTableReqDTO getCourseTableReqFromJson(String str) =>
    GetCourseTableReqDTO.fromJson(json.decode(str));

String getCourseTableReqToJson(GetCourseTableReqDTO data) =>
    json.encode(data.toJson());

class GetCourseTableReqDTO {
  GetCourseTableReqDTO({
    required this.userId,
    required this.username,
    required this.cookieList,
  });

  String userId;
  String username;
  List<ForestCookie> cookieList;

  factory GetCourseTableReqDTO.fromJson(Map<String, dynamic> json) =>
      GetCourseTableReqDTO(
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
