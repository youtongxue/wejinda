import 'package:get/get.dart';

import '../utils/dioUtil.dart';

class SchoolCardApi extends GetxService {
  final DioUtils cardDio = DioUtils();

  /// 用户登录
  dynamic login(String username, String password) async {
    Map data = {
      "username": username,
      "password": password,
    };
    return await cardDio.post("/campuscard/userinfo", data: data);
  }

  /// 账号挂失解挂
  loss(Map<String, dynamic> lossRequestData) async {
    return await cardDio.post("/campuscard/loss", data: lossRequestData);
  }

  /// 修改单日额度
  limitMoney(Map<String, dynamic> requestData) async {
    return await cardDio.post("/campuscard/limit", data: requestData);
  }
}
