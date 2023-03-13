// To parse this JSON data, do
//
//     final courseTableData = courseTableDataFromJson(jsonString);

import 'dart:convert';

import '../../timetable/CourseInfo.dart';

CourseTableData courseTableDataFromJson(String str) =>
    CourseTableData.fromJson(json.decode(str));

String courseTableDataToJson(CourseTableData data) =>
    json.encode(data.toJson());

class CourseTableData {
  CourseTableData({
    required this.code,
    required this.message,
    required this.result,
  });

  String code;
  String message;
  List<List<List<CourseInfo>>> result;

  factory CourseTableData.fromJson(Map<String, dynamic> json) =>
      CourseTableData(
        code: json["code"],
        message: json["message"],
        result: List<List<List<CourseInfo>>>.from(json["result"].map((x) =>
            List<List<CourseInfo>>.from(x.map((x) =>
                List<CourseInfo>.from(x.map((x) => CourseInfo.fromJson(x))))))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => List<dynamic>.from(
            x.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))))),
      };
}
