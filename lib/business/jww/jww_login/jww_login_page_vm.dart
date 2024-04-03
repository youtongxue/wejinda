import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wejinda/enumm/storage_key_enum.dart';
import 'package:wejinda/manager/app_user_info_manager.dart';
import 'package:wejinda/business/user/repository/account_data_service.dart';

import '../../user/dto/app_user_dto.dart';
import '../../../enumm/net_page_state_enum.dart';
import 'dto/login_first_rec_dto.dart';
import 'dto/login_rec_dto.dart';
import 'dto/login_req_dto.dart';
import '../api/jww_api.dart';
import '../../user/api/user_info_api.dart';
import '../../../net/net_manager.dart';
import '../../../utils/page_path_util.dart';

class JwwLoginPageViewModel extends GetxController {
  // 依赖
  final userInfoApi = Get.find<UserInfoApi>();
  final accountDataService = Get.find<AccountDataService>();
  final jwwApi = Get.find<JwwApi>();

  //状态
  var netPageState = NetPageStateEnum.pageLoading.obs;
  var errorPageData = ''.obs;
  var checkboxSelected = true.obs;

  var username = ''.obs;
  var password = ''.obs;

  // 界面相关

  // event: 点击登陆按钮 -> 检查输入参数，开始网络请求登陆
  void login() async {
    if (username.value.isEmpty ||
        password.value.isEmpty ||
        checkboxSelected.value == false) {
      return;
    }

    NetManager.request(
      netFun: jwwApi.loginFirst(),
      onDataSuccess: (rightData) async {
        // 登陆第二步
        loginNext(LoginFirstRecDTO.fromJson(rightData));
      },
    );
  }

  // 教务网登陆第二步
  void loginNext(LoginFirstRecDTO loginFirstRec) {
    // 构建请求体
    final LoginReqDTO loginBody = LoginReqDTO(
        username: username.value,
        password: password.value,
        viewState: loginFirstRec.viewState,
        cookieList: loginFirstRec.cookieList);

    NetManager.request(
      netPageState: netPageState,
      errorData: errorPageData,
      netFun: jwwApi.login(loginBody),
      onDataSuccess: (rightData) async {
        final LoginRecDTO loginRec = LoginRecDTO.fromJson(rightData);
        // 登陆成功后跳转到主页,传递参数
        Map<String, dynamic> arg = {
          "loginFirstRec": loginFirstRec,
          "loginRec": loginRec,
        };

        // 先存储再跳转，否则中间件回循环重定向到登陆界面
        accountDataService.saveAccount(
            AccountStorageKeyEnum.jww, username.value, password.value);

        // 跳转
        Get.offNamed(PagePathUtil.jwwMainPage, arguments: arg);
      },
    );
  }
}
