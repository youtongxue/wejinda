// To parse this JSON data, do
//
//     final courseInfo = courseInfoFromJson(jsonString);

import 'dart:convert';

CourseInfo courseInfoFromJson(String str) =>
    CourseInfo.fromJson(json.decode(str));

String courseInfoToJson(CourseInfo data) => json.encode(data.toJson());

class CourseInfo {
  CourseInfo({
    required this.name,
    required this.week,
    required this.timeStart,
    required this.timeEnd,
    required this.weekStart,
    required this.weekEnd,
    required this.teacher,
    required this.address,
    required this.color,
  });

  String? name;
  String? week;
  String? timeStart;
  String? timeEnd;
  String? weekStart;
  String? weekEnd;
  String? teacher;
  String? address;
  String? color;

  factory CourseInfo.fromJson(Map<String, dynamic> json) => CourseInfo(
      name: json["name"] ?? '',
      week: json["week"] ?? '',
      timeStart: json["timeStart"] ?? '',
      timeEnd: json["timeEnd"] ?? '',
      weekStart: json["weekStart"] ?? '',
      weekEnd: json["weekEnd"] ?? '',
      teacher: json["teacher"] ?? '',
      address: json["address"] ?? '',
      color: json["color"] ?? '0x0000000');

  Map<String, dynamic> toJson() => {
        "name": name,
        "week": week,
        "timeStart": timeStart,
        "timeEnd": timeEnd,
        "weekStart": weekStart,
        "weekEnd": weekEnd,
        "teacher": teacher,
        "address": address,
        "color": color,
      };

  @override
  String toString() {
    final str =
        "name: $name, week: $week, timeStart: $timeStart, weekStart: $weekStart, weekEnd: $weekEnd, teacher: $teacher, address: $address, color: $color";
    return str;
  }
}
