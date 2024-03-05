import 'package:dio/dio.dart' as dio;
import 'package:wejinda/bean/to/user/app_user_dto.dart';

abstract class UserInfoApi {
  // 发送注册验证码
  dynamic sendRegisterCode(String email);

  // 头像上传
  dynamic uploadUserAvatarImg(String email, dio.FormData fromDate);

  // 注册用户
  dynamic userRegister(String registerCode, AppUserDTO appUserDTO);

  // 用户登陆
  dynamic userLogin(String username, String password);

  // 更新用户信息
  dynamic userUpdate(AppUserDTO appUserDTO);

  // 发送注销账号验证码
  dynamic userLogoutCode();

  // 注销账号
  dynamic userLogout();

  // 根据用户邮箱查找用户头像
  dynamic getUserAvatarByEmail(String email);
}
