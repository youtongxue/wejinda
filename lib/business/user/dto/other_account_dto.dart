class OtherAccountDTO {
  int otherAccountEnum;
  String username;
  String password;

  OtherAccountDTO({
    required this.otherAccountEnum,
    required this.username,
    required this.password,
  });

  factory OtherAccountDTO.fromJson(Map<String, dynamic> json) =>
      OtherAccountDTO(
        otherAccountEnum: json["otherAccountEnum"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "otherAccountEnum": otherAccountEnum,
        "username": username,
        "password": password,
      };
}

enum OtherAccountEnum {
  jww(type: 0),
  ;

  final int type;

  const OtherAccountEnum({
    required this.type,
  });
}
