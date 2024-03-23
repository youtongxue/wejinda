import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bean/to/user/app_user_dto.dart';
import '../../net/base/base_api.dart';
import '../../utils/dio_util.dart';

class UserPageViewModel extends GetxController {
  ScrollController scrollController = ScrollController();
  var offset = 0.0.obs;
  var userBgPicScale = 1.0.obs; // 图片放大倍数

  Rx<AppUserDTO?> loginedAppUserDTO = Rx<AppUserDTO?>(null);

  void loginInit(AppUserDTO appUserDTO) {
    // 初始化登陆后的Dio实例
    BaseApiService.ableBaseUrlDio = DioUtil.getDio(DioConfig.loginedBaseUrl,
        loginToken: appUserDTO.loginToken);
    // 更新登陆状态
    loginedAppUserDTO(appUserDTO);
  }

  bool isLogin() {
    return (null == loginedAppUserDTO.value) ? false : true;
  }

  /// 设置背景图片随，滚动的的放大倍数
  void _setScale(double offset) {
    if (offset < 0) {
      final scale = 1 + offset.abs() / 300;
      userBgPicScale.value = scale.clamp(1, 3).toDouble();
    }
  }

  @override
  void onReady() {
    super.onReady();
    scrollController.addListener(() {
      offset.value = scrollController.offset;
      // debugPrint('offset: > > > ${offset.value}}');
      _setScale(offset.value);
      // debugPrint('滑动偏差: ${offset.value}');
    });
  }
}
