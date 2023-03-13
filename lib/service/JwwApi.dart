import 'package:get/get.dart';
import 'package:wejinda/net/jww/request/GetCourseTableReq.dart';

import '../net/jww/request/LoginReq.dart';
import '../utils/dioUtil.dart';

class JwwApi extends GetxService {
  final DioUtils _cardDio = DioUtils();

  // 登陆第一步
  dynamic loginFirst() async {
    return await _cardDio.get("/jww/first");
  }

  // 登录
  dynamic login(LoginReq loginReq) async {
    return await _cardDio.post("/jww/login", data: loginReq);
  }

  // 获取课表信息
  dynamic getCourseTable(GetCourseTableReq getCourseTableReq) async {
    return await _cardDio.post("/jww/kb", data: getCourseTableReq);
  }
}
