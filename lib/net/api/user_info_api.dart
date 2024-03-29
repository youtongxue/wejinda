import 'package:dio/dio.dart' as dio;
import 'package:wejinda/bean/to/user/app_user_dto.dart';
import 'package:wejinda/views/user/update_password/update_password_dto.dart';

import '../../views/user/retrieve_password/retrieve_password_dto.dart';

abstract class UserInfoApi {
  // 发送注册验证码
  dynamic sendRegisterCode(String email);

  // 发送修改密码验证码
  dynamic sendUpdatePasswordCode(String email);

  // 更新密码
  dynamic updatePassword(UpdatePasswordDto updatePasswordDto);

  // 发送找回密码验证码
  dynamic sendRetrievePasswordCode(String email);

  // 找回修改密码
  dynamic retrievePassword(RetrievePasswordDto retrievePasswordDto);

  // 头像上传
  dynamic uploadUserAvatarImg(String email, dio.FormData fromDate);

  // 注册用户
  dynamic userRegister(String registerCode, AppUserDTO appUserDTO);

  // 用户登陆
  dynamic userLogin(String username, String password);

  // 更新用户信息
  dynamic userUpdate(AppUserDTO appUserDTO);

  // 发送注销账号验证码
  dynamic sendDelAccountCode();

  // 注销账号
  dynamic delAccount(String verifyCode);

  // 根据用户邮箱查找用户头像
  dynamic getUserAvatarByEmail(String email);
}
