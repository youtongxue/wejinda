import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/service/PrefesService.dart';

import '../enum/loginEnum.dart';

class SchoolCardPgeMiddleWare extends GetMiddleware {
  late final prefesService = Get.find<PrefesService>();

  @override
  int? priority = 0;

  SchoolCardPgeMiddleWare({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    print("$route 路由中间件");

    // 本地无账号信息登录
    if (prefesService.prefers.getString(UserLoginEnum.SchoolCard.username) ==
        null) {
      // 重定向到登录页面
      return const RouteSettings(name: "/schoolCardLoginPage");
    }
    return null;
  }
}
