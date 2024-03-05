import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../../bean/to/user/app_user_dto.dart';
import '../../../net/api/user_info_api.dart';
import '../../../utils/net_uitl.dart';
import '../../../viewmodel/user/user_page_vm.dart';

class StudentIdPageViewModel extends GetxController {
  final userInfoApi = Get.find<UserInfoApi>();
  final userModel = Get.find<UserPageViewModel>();

  TextEditingController textController = TextEditingController();

  int maxLines = 2;

  String studentIdTemp = '';
  var errorInfo = ''.obs;

  void updateStudentId() {
    if (textController.text.isEmpty) {
      debugPrint('学号不能为空');
      errorInfo.value = '学号不能为空';
      return;
    }

    final newAppUserDTO = userModel.loginedAppUserDTO.value!
        .copyWith(studentNum: textController.text);

    NetUtil.request(
      netFun: userInfoApi.userUpdate(newAppUserDTO),
      onDataSuccess: (rightData) async {
        final newAppUserDTO = AppUserDTO.fromJson(rightData);
        SmartDialog.showToast('修改成功!');
        userModel.loginedAppUserDTO.value = newAppUserDTO;
        Get.back();
      },
    );
  }

  @override
  void onInit() {
    super.onInit();

    studentIdTemp = userModel.loginedAppUserDTO.value?.studentNum ?? '';
    textController.text = studentIdTemp;

    textController.addListener(() {
      if (textController.text.isEmpty) {
        errorInfo.value = '学号不能为空';
      } else if (textController.text.isEmail) {
        errorInfo.value = '学号不能为邮箱';
      } else {
        errorInfo.value = '';
      }
    });
  }
}
