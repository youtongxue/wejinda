// To parse this JSON data, do
//
//     final retrievePasswordDto = retrievePasswordDtoFromJson(jsonString);

import 'dart:convert';

RetrievePasswordDto retrievePasswordDtoFromJson(String str) =>
    RetrievePasswordDto.fromJson(json.decode(str));

String retrievePasswordDtoToJson(RetrievePasswordDto data) =>
    json.encode(data.toJson());

class RetrievePasswordDto {
  String verifyCode;
  String email;
  String password;

  RetrievePasswordDto({
    required this.verifyCode,
    required this.email,
    required this.password,
  });

  factory RetrievePasswordDto.fromJson(Map<String, dynamic> json) =>
      RetrievePasswordDto(
        verifyCode: json["verifyCode"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "verifyCode": verifyCode,
        "email": email,
        "password": password,
      };
}
