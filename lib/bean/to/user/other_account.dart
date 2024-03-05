class OtherAccount {
  int otherAccountEnum;
  String username;
  String password;

  OtherAccount({
    required this.otherAccountEnum,
    required this.username,
    required this.password,
  });

  factory OtherAccount.fromJson(Map<String, dynamic> json) => OtherAccount(
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
