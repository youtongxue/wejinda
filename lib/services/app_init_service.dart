import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wejinda/business/service_environment/repository/base_url_impl.dart';
import 'package:wejinda/business/service_environment/repository/base_url_service.dart';
import 'package:wejinda/utils/dio_util.dart';

import '../business/app/api/app_info_api.dart';
import '../business/user/api/user_info_api.dart';
import '../business/app/api/app_info_api_impl.dart';
import '../business/user/api/user_info_api_impl.dart';
import '../business/user/repository/account_data_impl.dart';
import '../business/user/repository/account_data_service.dart';
import '../business/user/account_center/user_page_vm.dart';

class AppInitService {
  static Future<void> init() async {
    debugPrint('< < <   全局初始化 start...   > > >');
    // 初始化 WidgetsFlutterBinding
    WidgetsFlutterBinding.ensureInitialized();

    // 初始化状态栏、导航栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: false,
    ));

    // 初始化本地存储服务
    final getStorage = await GetStorage.init();
    getStorage
        ? debugPrint("初始化全局单例 GetStorage 完成✅")
        : debugPrint("初始化全局单例 GetStorage 失败❌");

    // 初始化本地时间服务
    initializeDateFormatting(); // 初始化日期格式化信息
    debugPrint("初始化日期格式化信息 完成✅");

    // 初始化用户信息ViewModel
    Get.put<BaseUrlService>(BaseUrlImpl());
    DioUtil.init();
    Get.put<UserInfoApi>(UserInfoApiImpl());
    Get.put<AppInfoApi>(AppInfoApiImpl());
    Get.lazyPut<AccountDataService>(() => AccountDataImpl());
    Get.lazyPut(() => UserPageViewModel(), fenix: true);

    debugPrint('< < <   全局初始化 end...   > > >');
  }
}
