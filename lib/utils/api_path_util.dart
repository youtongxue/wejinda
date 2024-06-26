import 'package:get/get.dart';
import 'package:wejinda/business/service_environment/repository/base_url_service.dart';

class ApiPathUtil {
  static final baseUrlService = Get.find<BaseUrlService>();
  ApiPathUtil._();

  // static const String springBootBaseUrl = "https://singlestep.cn/wejinda";
  //static const String springBootBaseUrl = "http://192.168.27.5:8080/wejinda";

  static const String appInfo = "/app/info";
  static const String campuscardUserInfo = "/campuscard/userinfo";

  static const String userRegisterCode = "/user/registerCode";
  static const String userUpdatePasswordCode = "/user/updatePasswordCode";
  static const String retrieveCodePasswordCode = "/user/retrieveCode";
  static const String delAccountVerifyCode = "/user/delCode";
  static const String delAccount = "/user/del";
  static const String userUpdatePassword = "/user/updatePassword";
  static const String retrievePassword = "/user/retrievePassword";
  static const String uploadUserAvatarImg = "/upload/userAvatarImg";
  static const String userRegister = "/user/register";
  static const String userLogin = "/user/login";
  static const String userUpdate = "/user/update";
  static const String getUserAvatarByEmail = "/user/loginuseravatar";

  static const String loginFirst = "/jww/first";
  static const String login = "/jww/login";
  static const String getCourseTable = "/jww/kb";
  static const String getExamTime = "/jww/exam";
  static const String getExamInfo = "/jww/examinfo";
  static const String getScoreTime = "/jww/score";
  static const String getScoreInfo = "/jww/scoreinfo";

  static String getSpringBootBaseUrl() {
    return baseUrlService.getURL();
  }

  static void setSpringBootBaseUrl(String baseUrl) {
    return baseUrlService.saveURL(baseUrl);
  }
}
