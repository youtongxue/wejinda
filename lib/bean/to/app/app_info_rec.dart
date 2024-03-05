// To parse this JSON data, do
//
//     final appInfoTo = appInfoToFromJson(jsonString);

import 'dart:convert';

AppInfoRec appInfoToFromJson(String str) =>
    AppInfoRec.fromJson(json.decode(str));

String appInfoToToJson(AppInfoRec data) => json.encode(data.toJson());

class AppInfoRec {
  String appVersion;
  String updateDesc;

  AppInfoRec({
    required this.appVersion,
    required this.updateDesc,
  });

  factory AppInfoRec.fromJson(Map<String, dynamic> json) => AppInfoRec(
        appVersion: json["appVersion"],
        updateDesc: json["updateDesc"],
      );

  Map<String, dynamic> toJson() => {
        "appVersion": appVersion,
        "updateDesc": updateDesc,
      };
}
