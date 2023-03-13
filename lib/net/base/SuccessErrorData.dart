// To parse this JSON data, do
//
//     final successErrorData = successErrorDataFromJson(jsonString);

import 'dart:convert';

SuccessErrorData successErrorDataFromJson(String str) =>
    SuccessErrorData.fromJson(json.decode(str));

String successErrorDataToJson(SuccessErrorData data) =>
    json.encode(data.toJson());

class SuccessErrorData {
  SuccessErrorData({
    required this.code,
    required this.message,
    this.result,
  });

  String code;
  String message;
  dynamic result;

  factory SuccessErrorData.fromJson(Map<String, dynamic> json) =>
      SuccessErrorData(
        code: json["code"],
        message: json["message"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": result,
      };
}
