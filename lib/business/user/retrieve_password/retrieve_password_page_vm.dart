import 'package:get/get.dart';

import '../../../components/notification/custom_notification.dart';
import '../../../utils/page_path_util.dart';

class RetrievePasswordPageViewModel extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var passwordRe = ''.obs;

  /// 找回修改密码
  void retrievePassword() {
    if (email.value.isEmpty ||
        password.value.isEmpty ||
        passwordRe.value.isEmpty) return;
    if (password.value != passwordRe.value) {
      CustomNotification.toast(Get.context!, "密码不一致");
      return;
    }

    Get.offAndToNamed(PagePathUtil.retrievePasswordVerifyCodePage);
  }
}
