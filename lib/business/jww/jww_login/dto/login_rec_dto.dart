// To parse this JSON data, do
//
//     final jwwLoginRec = jwwLoginRecFromJson(jsonString);

import 'dart:convert';

LoginRecDTO jwwLoginRecFromJson(String str) =>
    LoginRecDTO.fromJson(json.decode(str));

String jwwLoginRecToJson(LoginRecDTO data) => json.encode(data.toJson());

// 教务网登陆成功后返回的 result 账号的个人信息
class LoginRecDTO {
  LoginRecDTO({
    required this.studentName,
    required this.userId,
    required this.department,
    required this.specialities,
    required this.userClass,
    required this.funCanItems, // 可以查询的功能
  });

  late String studentName;
  late String userId;
  String? department;
  String? specialities;
  String? userClass;
  Map<String, bool> funCanItems;

  factory LoginRecDTO.fromJson(Map<String, dynamic> json) => LoginRecDTO(
        studentName: json["studentName"],
        userId: json["userId"],
        department: json["department"],
        specialities: json["specialities"],
        userClass: json["userClass"],
        funCanItems: Map.from(json["funCanItems"])
            .map((k, v) => MapEntry<String, bool>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "studentName": studentName,
        "userId": userId,
        "department": department,
        "specialities": specialities,
        "userClass": userClass,
        "funCanItems": Map.from(funCanItems)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
