// To parse this JSON data, do
//
//     final normalSuccessData = normalSuccessDataFromJson(jsonString);

import 'dart:convert';

NormalSuccessData normalSuccessDataFromJson(String str) =>
    NormalSuccessData.fromJson(json.decode(str));

String normalSuccessDataToJson(NormalSuccessData data) =>
    json.encode(data.toJson());

class NormalSuccessData {
  NormalSuccessData({
    required this.code,
    required this.message,
    this.result,
  });

  String code;
  String message;
  dynamic result;

  factory NormalSuccessData.fromJson(Map<String, dynamic> json) =>
      NormalSuccessData(
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
