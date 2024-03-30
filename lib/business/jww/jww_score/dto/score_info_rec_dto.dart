// To parse this JSON data, do
//
//     final scoreInfo = scoreInfoFromJson(jsonString);

import 'dart:convert';

ScoreInfoRecDTO scoreInfoFromJson(String str) =>
    ScoreInfoRecDTO.fromJson(json.decode(str));

String scoreInfoToJson(ScoreInfoRecDTO data) => json.encode(data.toJson());

class ScoreInfoRecDTO {
  String xn;
  String xq;
  String id;
  String name;
  String type;
  String belong;
  String credit;
  String gpa;
  String score;
  String minor;
  String reScore;
  String reTestPaperScore;
  String retakeScore;
  String college;
  String remarks;
  String retake;

  ScoreInfoRecDTO({
    required this.xn,
    required this.xq,
    required this.id,
    required this.name,
    required this.type,
    required this.belong,
    required this.credit,
    required this.gpa,
    required this.score,
    required this.minor,
    required this.reScore,
    required this.reTestPaperScore,
    required this.retakeScore,
    required this.college,
    required this.remarks,
    required this.retake,
  });

  factory ScoreInfoRecDTO.fromJson(Map<String, dynamic> json) =>
      ScoreInfoRecDTO(
        xn: json["xn"],
        xq: json["xq"],
        id: json["id"],
        name: json["name"],
        type: json["type"],
        belong: json["belong"],
        credit: json["credit"],
        gpa: json["gpa"],
        score: json["score"],
        minor: json["minor"],
        reScore: json["reScore"],
        reTestPaperScore: json["reTestPaperScore"],
        retakeScore: json["retakeScore"],
        college: json["college"],
        remarks: json["remarks"],
        retake: json["retake"],
      );

  Map<String, dynamic> toJson() => {
        "xn": xn,
        "xq": xq,
        "id": id,
        "name": name,
        "type": type,
        "belong": belong,
        "credit": credit,
        "gpa": gpa,
        "score": score,
        "minor": minor,
        "reScore": reScore,
        "reTestPaperScore": reTestPaperScore,
        "retakeScore": retakeScore,
        "college": college,
        "remarks": remarks,
        "retake": retake,
      };
}
