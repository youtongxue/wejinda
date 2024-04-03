import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/enumm/storage_key_enum.dart';
import 'package:wejinda/utils/storage_util.dart';

import '../utils/page_path_util.dart';

// 教务网主页面路由中间件
class JwwLoginMw extends GetMiddleware {
  JwwLoginMw();

  @override
  RouteSettings? redirect(String? route) {
    if (!GetStorageUtil.hasData(AccountStorageKeyEnum.jww.username)) {
      debugPrint("$route 无本地 教务网账号信息❌ 重定向 -> AppRountes.jwwLoginPage");

      return const RouteSettings(name: PagePathUtil.jwwLoginPage);
    }

    return super.redirect(route);
  }
}

// 首次进入App需要读取本地数据进行登陆
class UserLoginMw extends GetMiddleware {
  UserLoginMw();

  @override
  RouteSettings? redirect(String? route) {
    if (!GetStorageUtil.hasData(AccountStorageKeyEnum.appUser.username)) {
      debugPrint("$route 无本地 App用户账号信息❌ 重定向 -> AppRountes.userLoginPage");

      return const RouteSettings(name: PagePathUtil.userLoginPage);
    }

    return super.redirect(route);
  }
}
