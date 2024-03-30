import 'dart:convert';

import 'other_account_dto.dart';

AppUserDTO appUserDtoFromJson(String str) =>
    AppUserDTO.fromJson(json.decode(str));

String appUserDtoToJson(AppUserDTO data) => json.encode(data.toJson());

class AppUserDTO {
  String username;
  String password;
  String? introduction;
  String? sex;
  String? major;
  List<OtherAccountDTO> otherAccount;
  String userImg;
  String? userBgImg;
  String email;
  String? studentNum;
  String? loginToken;
  String? userId;
  String? createDate;

  AppUserDTO({
    required this.username,
    required this.password,
    this.introduction,
    this.sex,
    this.major,
    this.otherAccount = const [],
    required this.userImg,
    this.userBgImg,
    required this.email,
    required this.studentNum,
    this.loginToken,
    this.userId,
    this.createDate,
  });

  AppUserDTO copyWith({
    String? username,
    String? password,
    String? introduction,
    String? sex,
    String? major,
    List<OtherAccountDTO>? otherAccount,
    String? userImg,
    String? userBgImg,
    String? email,
    String? studentNum,
    String? loginToken,
    String? userId,
    String? createDate,
  }) {
    return AppUserDTO(
      username: username ?? this.username,
      password: password ?? this.password,
      introduction: introduction ?? this.introduction,
      sex: sex ?? this.sex,
      major: major ?? this.major,
      otherAccount: otherAccount ?? this.otherAccount,
      userImg: userImg ?? this.userImg,
      userBgImg: userBgImg ?? this.userBgImg,
      email: email ?? this.email,
      studentNum: studentNum ?? this.studentNum,
      loginToken: loginToken ?? this.loginToken,
      userId: userId ?? this.userId,
      createDate: createDate ?? this.createDate,
    );
  }

  factory AppUserDTO.fromJson(Map<String, dynamic> json) => AppUserDTO(
        username: json["username"],
        password: json["password"],
        introduction: json["introduction"] ?? '',
        sex: json["sex"] ?? '',
        major: json["major"] ?? '',
        otherAccount: List<OtherAccountDTO>.from(
            json["otherAccount"].map((x) => OtherAccountDTO.fromJson(x))),
        userImg: json["userImg"],
        userBgImg: json["userBgImg"] ?? '',
        email: json["email"],
        studentNum: json["studentNum"] ?? '',
        loginToken: json["loginToken"],
        userId: json["userId"],
        createDate: json["createDate"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "introduction": introduction,
        "sex": sex,
        "major": major,
        "otherAccount": List<dynamic>.from(otherAccount.map((x) => x.toJson())),
        "userImg": userImg,
        "userBgImg": userBgImg,
        "email": email,
        "studentNum": studentNum,
        "loginToken": loginToken,
        "userId": userId,
        "createDate": createDate,
      };
}
