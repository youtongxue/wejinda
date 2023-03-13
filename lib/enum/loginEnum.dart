// 用户登录属性名，枚举定义
enum UserLoginEnum {
  SchoolCard(username: "SchoolCardUserName", password: "SchoolCardPassword"),
  Jww(username: "JwwUserName", password: "JwwPassword"),
  Library(username: "LibraryUserName", password: "LibraryPassword"),
  ;

  final String username;
  final String password;

  const UserLoginEnum({
    required this.username,
    required this.password,
  });
}
