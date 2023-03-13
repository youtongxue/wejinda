import 'package:get/get.dart';

import '../../enum/loginEnum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPageController extends GetxController {
  late final SharedPreferences prefers;
  var jwwUsername = ''.obs;
  var libraryUsername = ''.obs;
  var schoolCardUsername = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    ///将 Prefes 中数据同步到 Controller 中
    prefers = await SharedPreferences.getInstance();

    jwwUsername.value = prefers.getString(UserLoginEnum.Jww.username) ?? '';
    libraryUsername.value =
        prefers.getString(UserLoginEnum.Library.username) ?? '';
    schoolCardUsername.value =
        prefers.getString(UserLoginEnum.SchoolCard.username) ?? '';
  }

  /// 删除 Prefes 中数据
  delPrefesAccount(UserLoginEnum userLoginEnum) {
    switch (userLoginEnum) {
      case UserLoginEnum.Jww:
        {}
        break;
      case UserLoginEnum.Library:
        {}
        break;
      case UserLoginEnum.SchoolCard:
        {
          // 删除 Prefes 中数据
          prefers.remove(UserLoginEnum.SchoolCard.username);
          prefers.remove(UserLoginEnum.SchoolCard.password);
          // 更新 Controller 中数据
          schoolCardUsername.value = '';
        }
        break;
    }
  }
}
