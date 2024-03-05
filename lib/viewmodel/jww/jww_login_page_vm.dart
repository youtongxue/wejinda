import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wejinda/bean/to/user/other_account.dart';
import 'package:wejinda/enumm/storage_key_enum.dart';
import 'package:wejinda/repository/account/account_data_service.dart';

import '../../bean/to/user/app_user_dto.dart';
import '../../enumm/net_page_state_enum.dart';
import '../../bean/to/jww/rec/login_first_rec.dart';
import '../../bean/to/jww/rec/login_rec.dart';
import '../../bean/to/jww/req/login_req.dart';
import '../../net/api/jww_api.dart';
import '../../net/api/user_info_api.dart';
import '../../utils/net_uitl.dart';
import '../../utils/page_path_util.dart';
import '../user/user_page_vm.dart';

class JwwLoginPageViewModel extends GetxController {
  // 依赖
  final userInfoApi = Get.find<UserInfoApi>();
  final userModel = Get.find<UserPageViewModel>();
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

    NetUtil.request(
      netFun: jwwApi.loginFirst(),
      onDataSuccess: (rightData) async {
        // 登陆第二步
        loginNext(LoginFirstRec.fromJson(rightData));
      },
    );
  }

  // 教务网登陆第二步
  void loginNext(LoginFirstRec loginFirstRec) {
    // 构建请求体
    final LoginReq loginBody = LoginReq(
        username: username.value,
        password: password.value,
        viewState: loginFirstRec.viewState,
        cookieList: loginFirstRec.cookieList);

    NetUtil.request(
      netPageState: netPageState,
      errorData: errorPageData,
      netFun: jwwApi.login(loginBody),
      onDataSuccess: (rightData) async {
        final LoginRec loginRec = LoginRec.fromJson(rightData);
        // 登陆成功后跳转到主页,传递参数
        Map<String, dynamic> arg = {
          "loginFirstRec": loginFirstRec,
          "loginRec": loginRec,
        };

        // 先存储再跳转，否则中间件回循环重定向到登陆界面
        accountDataService.saveAccount(
            AccountStorageKeyEnum.jww, username.value, password.value);
        // 同步到云
        updateOtherAccount(
            OtherAccountEnum.jww.type, username.value, password.value);

        // 跳转
        Get.offNamed(PagePathUtil.jwwMainPage, arguments: arg);
      },
    );
  }

  Future<void> updateOtherAccount(
      int otherAccountEnum, String username, String password) async {
    if ((userModel.loginedAppUserDTO.value?.studentNum == null) ||
        userModel.loginedAppUserDTO.value!.studentNum != username) return;

    // 是否已经存在
    final loginedOtherAccountList =
        userModel.loginedAppUserDTO.value!.otherAccount;
    for (var otherAccount in loginedOtherAccountList) {
      if (otherAccount.otherAccountEnum == otherAccountEnum) return;
    }

    final jwwAccount = OtherAccount(
        otherAccountEnum: otherAccountEnum,
        username: username,
        password: password);
    loginedOtherAccountList.add(jwwAccount);

    NetUtil.request(
      netFun: userInfoApi.userUpdate(userModel.loginedAppUserDTO.value!),
      onDataSuccess: (rightData) async {
        final newAppUserDTO = AppUserDTO.fromJson(rightData);
        SmartDialog.showToast('修改成功!');
        userModel.loginedAppUserDTO.value = newAppUserDTO;
      },
    );
  }
}
