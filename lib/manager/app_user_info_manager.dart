import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../bean/to/user/app_user_dto.dart';
import '../bean/to/user/other_account.dart';
import '../enumm/storage_key_enum.dart';
import '../net/api/user_info_api.dart';
import '../repository/account/account_data_service.dart';
import '../utils/dio_util.dart';
import '../utils/net_uitl.dart';
import '../utils/page_path_util.dart';
import '../viewmodel/user/user_page_vm.dart';

class AppUserInfoManager {
  final accountDataService = Get.find<AccountDataService>();
  final userInfoApi = Get.find<UserInfoApi>();
  final userPageViewModel = Get.find<UserPageViewModel>();

  Rx<AppUserDTO?> appUserDTO = Rx<AppUserDTO?>(null);

  // 私有构造函数
  AppUserInfoManager._privateConstructor();

  // 静态私有实例变量
  static final AppUserInfoManager _instance =
      AppUserInfoManager._privateConstructor();

  // 工厂构造函数
  factory AppUserInfoManager() {
    return _instance;
  }

  /// 账号自动登陆，从本地缓存中读取账号、密码信息
  Future<void> autoAppUserLogin() async {
    debugPrint("自动登录: > > > >");
    // 自动登陆
    final appAccount =
        accountDataService.getAccount(AccountStorageKeyEnum.appUser);
    await NetUtil.request(
      netFun: userInfoApi.userLogin(appAccount.username!, appAccount.password!),
      onDataSuccess: (rightData) async {
        final appUserLoginRec = AppUserDTO.fromJson(rightData);
        // 本地存储用户账号、密码信息
        accountDataService.saveAccount(AccountStorageKeyEnum.appUser,
            appUserLoginRec.email, appAccount.password!); // 这里密码需要存储真实密码
        // 同步教务网密码到本地
        final loginedOtherAccountList = appUserLoginRec.otherAccount;
        for (var i = 0; i < loginedOtherAccountList.length; i++) {
          if (loginedOtherAccountList[i].otherAccountEnum ==
              OtherAccountEnum.jww.type) {
            accountDataService.saveAccount(
                AccountStorageKeyEnum.jww,
                loginedOtherAccountList[i].username,
                loginedOtherAccountList[i].password);
          }
        }
        // 初始化登陆后的Dio实例
        DioUtil.initDioConfig(DioConfig.defaultBaseUrl,
            loginToken: appUserLoginRec.loginToken);
        // 更新登陆信息
        appUserDTO(appUserLoginRec);
      },
      onDataError: (errorData) async {
        Get.toNamed(PagePathUtil.userLoginPage);
      },
      onDioException: (dioException) async {
        Get.toNamed(PagePathUtil.userLoginPage);
      },
      onNetError: (errorData) async {
        Get.toNamed(PagePathUtil.userLoginPage);
      },
    );
  }

  /// 从本地缓存中读取账号、传入密码
  Future<void> appUserLogin(String email, String password) async {
    debugPrint("登录: > > > >");
    await NetUtil.request(
      netFun: userInfoApi.userLogin(email, password),
      onDataSuccess: (rightData) async {
        final appUserLoginRec = AppUserDTO.fromJson(rightData);
        // 本地存储用户账号、密码信息
        accountDataService.saveAccount(AccountStorageKeyEnum.appUser,
            appUserLoginRec.email, password); // 这里密码需要存储真实密码
        // 同步教务网密码到本地
        final loginedOtherAccountList = appUserLoginRec.otherAccount;
        for (var i = 0; i < loginedOtherAccountList.length; i++) {
          if (loginedOtherAccountList[i].otherAccountEnum ==
              OtherAccountEnum.jww.type) {
            accountDataService.saveAccount(
                AccountStorageKeyEnum.jww,
                loginedOtherAccountList[i].username,
                loginedOtherAccountList[i].password);
          }
        }
        // 初始化登陆后的Dio实例
        DioUtil.initDioConfig(DioConfig.defaultBaseUrl,
            loginToken: appUserLoginRec.loginToken);
        // 更新登陆信息
        appUserDTO(appUserLoginRec);
      },
      onDataError: (errorData) async {
        Get.toNamed(PagePathUtil.userLoginPage);
      },
      onDioException: (dioException) async {
        Get.toNamed(PagePathUtil.userLoginPage);
      },
      onNetError: (errorData) async {
        Get.toNamed(PagePathUtil.userLoginPage);
      },
    );
  }

  /// 全局获取用户登陆信息
  AppUserDTO? getAppUserDTO() {
    return appUserDTO.value;
  }

  /// 是否登陆
  bool isLogined() {
    return null != appUserDTO.value;
  }

  /// 退出登陆
  void signOut() {
    appUserDTO = Rx<AppUserDTO?>(null);
    accountDataService.delAccount(AccountStorageKeyEnum.jww);
    accountDataService.delAccount(AccountStorageKeyEnum.appUser);

    Get.offAllNamed(PagePathUtil.userLoginPage);

    debugPrint("username: ${appUserDTO.value?.email}");
  }

  /// 更新用户信息
  void updateAppUserInfoDTO(AppUserDTO newAppUserDTO) {
    appUserDTO(newAppUserDTO);
  }
}
