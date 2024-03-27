// To parse this JSON data, do
//
//     final updatePasswordDto = updatePasswordDtoFromJson(jsonString);

import 'dart:convert';

UpdatePasswordDto updatePasswordDtoFromJson(String str) =>
    UpdatePasswordDto.fromJson(json.decode(str));

String updatePasswordDtoToJson(UpdatePasswordDto data) =>
    json.encode(data.toJson());

class UpdatePasswordDto {
  String verifyCode;
  String password;

  UpdatePasswordDto({
    required this.verifyCode,
    required this.password,
  });

  factory UpdatePasswordDto.fromJson(Map<String, dynamic> json) =>
      UpdatePasswordDto(
        verifyCode: json["verifyCode"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "verifyCode": verifyCode,
        "password": password,
      };
}
