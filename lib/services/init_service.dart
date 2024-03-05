import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wejinda/net/base/base_api.dart';

import '../net/api/user_info_api.dart';
import '../net/impl/user_info_api_impl.dart';
import '../repository/account/account_data_impl.dart';
import '../repository/account/account_data_service.dart';
import '../viewmodel/user/user_page_vm.dart';

class InitService {
  static Future<void> init() async {
    debugPrint('< < <   全局初始化 start...   > > >');
    // 初始化 WidgetsFlutterBinding
    WidgetsFlutterBinding.ensureInitialized();

    // 初始化本地存储服务
    final getStorage = await GetStorage.init();
    getStorage
        ? debugPrint("初始化全局单例 GetStorage 完成✅")
        : debugPrint("初始化全局单例 GetStorage 失败❌");

    // 初始化本地时间服务
    initializeDateFormatting(); // 初始化日期格式化信息
    debugPrint("初始化日期格式化信息 完成✅");

    // 初始化用户信息ViewModel
    //Get.lazyPut(() => BaseApiService());
    Get.put(BaseApiService());
    Get.lazyPut<AccountDataService>(() => AccountDataImpl());
    Get.lazyPut(() => UserPageViewModel(), fenix: true);
    Get.lazyPut<UserInfoApi>(() => UserInfoApiImpl());

    debugPrint('< < <   全局初始化 end...   > > >');
  }
}
