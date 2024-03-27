import 'package:get/get.dart';
import 'package:wejinda/components/notification/custom_notification.dart';
import 'package:wejinda/utils/page_path_util.dart';

class UpdatePasswordPageViewModel extends GetxController {
  var password = ''.obs; // 密码
  var passwordRe = ''.obs;

  /// 修改密码
  void updatePassword() {
    if (password.value.isEmpty || passwordRe.value.isEmpty) return;
    if (password.value != passwordRe.value) {
      CustomNotification.toast(Get.context!, "密码不一致");
      return;
    }

    Get.offAndToNamed(PagePathUtil.updatePasswordVerifyCodePage);
  }
}
