import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/net/jww/receive/LoginFirstRec.dart';
import 'package:wejinda/net/jww/receive/LoginRec.dart';
import 'package:wejinda/net/jww/request/LoginReq.dart';

import 'package:wejinda/routes/AppRountes.dart';
import 'package:wejinda/utils/netUtil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../service/JwwApi.dart';
import '../../service/PrefesService.dart';

class JwwLoginPageController extends GetxController {
  final PrefesService prefesService = Get.find<PrefesService>();
  final JwwApi jwwApi = Get.find<JwwApi>();

  late LoginRec loginRec;

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

  void login(LoginFirstRec loginFirstRec) {
    // 构建请求体
    final LoginReq loginBody = LoginReq(
        username: username.value,
        password: password.value,
        viewState: loginFirstRec.viewState,
        cookieList: loginFirstRec.cookieList);
    print("教务网登录执行 > > >");
    NetUtil.request(
      netFun: jwwApi.login(loginBody),
      netDone: (response) {
        NetUtil.checkResponse(
          response,
          onSuccessRightData: (rightData) {
            loginRec = LoginRec.fromJson(jsonDecode(rightData)['result']);
            print("登陆成功，> > > ${loginRec.studentName} ");
            // 登陆成功后跳转到主页
            // 需要把登陆成功后的获取的信息传递过去
            Map<String, dynamic> arg = {
              "loginFirstRec": loginFirstRec,
              "loginRec": loginRec,
            };
            Get.toNamed(AppRountes.jwwMainPage, arguments: arg);
          },
          onSuccessErrorData: (errorData) {},
          onError: (errorData) {},
          onDioError: (dioError) {},
        );
      },
    );
  }

  void loginFirst() async {
    // 点击登录 Button 收起键盘，释放焦点
    userFocusNode.unfocus();
    passFocusNode.unfocus();
    // 获取输入账号信息
    String username = nameController.text;
    String password = passController.text;
    // 判断输入是否为空...
    if (username.trim().isEmpty) {
      return SmartDialog.showToast('账号不能为空!');
    }

    if (password.trim().isEmpty) {
      return SmartDialog.showToast('密码不能为空!');
    }
    // 判断是否够选用户协议
    if (!checkboxSelected.value) {
      return SmartDialog.showToast('请阅读并勾服务协议、隐私政策');
    }

    print("教务网登录 First 执行 > > >");
    NetUtil.request(
      netFun: jwwApi.loginFirst(),
      netDone: (response) {
        NetUtil.checkResponse(
          response,
          onSuccessRightData: (rightData) {
            final LoginFirstRec loginFirstRec =
                LoginFirstRec.fromJson(jsonDecode(rightData)['result']);

            // 开始登陆
            login(loginFirstRec);
          },
          onSuccessErrorData: (errorData) {},
          onError: (errorData) {},
          onDioError: (dioError) {},
        );
      },
    );
  }
}
