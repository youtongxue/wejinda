import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:wejinda/routes/AppRountes.dart';
import 'package:wejinda/service/SchoolCardApi.dart';

import '../../net/schoolCard/schoolcarduser.dart';
import '../../enum/loginEnum.dart';
import '../../service/PrefesService.dart';
import '../../utils/netUtil.dart';

// 校园卡登录界面 Controller
class SchoolCardLoginPageController extends GetxController {
  final PrefesService prefesService = Get.find<PrefesService>();
  final SchoolCardApi schoolCardApi = Get.find<SchoolCardApi>();

  final nameController = TextEditingController();
  final passController = TextEditingController();

  final userFocusNode = FocusNode();
  final passFocusNode = FocusNode();

  var checkboxSelected = true.obs;
  var username = ''.obs;
  var password = ''.obs;

  bool showButton() {
    if (username.trimLeft().isNotEmpty &&
        password.trimLeft().isNotEmpty &&
        checkboxSelected.value == true) {
      return true;
    }
    return false;
  }

  // 校园卡用户登录
  login() async {
    print("controller 登录执行");
    // 点击登录 Button 收起键盘，释放焦点
    userFocusNode.unfocus();
    passFocusNode.unfocus();
    // 获取输入账号信息
    String username = nameController.text;
    String password = passController.text;
    // 判断输入是否为空...
    if (username.trimLeft().isEmpty) {
      return SmartDialog.showToast('账号不能为空!');
    }

    if (password.trimLeft().isEmpty) {
      return SmartDialog.showToast('密码不能为空!');
    }
    // 判断是否够选用户协议
    if (!checkboxSelected.value) {
      return SmartDialog.showToast('请阅读并勾服务协议、隐私政策');
    }

    NetUtil.request(
      netFun: schoolCardApi.login(username, password),
      netDone: (response) {
        NetUtil.checkResponse(
          response,
          onSuccessRightData: (rightData) {
            // 保存到 prefers
            prefesService.insertStringPrefes(
                UserLoginEnum.SchoolCard.username, username);
            prefesService.insertStringPrefes(
                UserLoginEnum.SchoolCard.password, password);

            // 将登录获取的用户信息传给 Card 页
            final SchoolCardUser schoolCardUser =
                SchoolCardUser.fromJson(jsonDecode(rightData)['result']);
            schoolCardUser.username = username;
            schoolCardUser.password = password;

            Get.offNamed(AppRountes.schoolCardPage, arguments: schoolCardUser);
          },
          onSuccessErrorData: (errorData) {},
          onError: (errorData) {},
          onDioError: (dioError) {},
        );
      },
    );
  }
}
