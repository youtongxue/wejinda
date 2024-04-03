import 'package:dio/dio.dart' as dio;
import 'package:wejinda/business/user/dto/app_user_dto.dart';
import 'package:wejinda/business/user/api/user_info_api.dart';
import 'package:wejinda/utils/api_path_util.dart';
import 'package:wejinda/business/user/update_password/update_password_dto.dart';

import '../../../utils/dio_util.dart';
import '../retrieve_password/retrieve_password_dto.dart';

class UserInfoApiImpl implements UserInfoApi {
  @override
  dynamic sendRegisterCode(String email) {
    final query = {
      "email": email,
    };
    return DioUtil.get(
      ApiPathUtil.userRegisterCode,
      queryParameters: query,
    );
  }

  @override
  dynamic uploadUserAvatarImg(String email, dio.FormData fromDate) {
    final query = {
      "email": email,
    };

    return DioUtil.post(
      ApiPathUtil.uploadUserAvatarImg,
      data: fromDate,
      queryParameters: query,
    );
  }

  @override
  userRegister(String registerCode, AppUserDTO appUserDTO) {
    final query = {
      "registerCode": registerCode,
    };

    return DioUtil.post(
      ApiPathUtil.userRegister,
      data: appUserDTO,
      queryParameters: query,
    );
  }

  @override
  userLogin(String username, String password) {
    final body = {
      "username": username,
      "password": password,
    };
    return DioUtil.post(
      ApiPathUtil.userLogin,
      data: body,
    );
  }

  @override
  userUpdate(AppUserDTO appUserDTO) {
    return DioUtil.post(ApiPathUtil.userUpdate, data: appUserDTO);
  }

  @override
  getUserAvatarByEmail(String email) {
    final query = {
      "email": email,
    };

    return DioUtil.post(
      ApiPathUtil.getUserAvatarByEmail,
      queryParameters: query,
    );
  }

  @override
  sendUpdatePasswordCode(String email) {
    final query = {
      "email": email,
    };
    return DioUtil.get(
      ApiPathUtil.userUpdatePasswordCode,
      queryParameters: query,
    );
  }

  @override
  updatePassword(UpdatePasswordDto updatePasswordDto) {
    return DioUtil.post(ApiPathUtil.userUpdatePassword,
        data: updatePasswordDto);
  }

  @override
  delAccount(String verifyCode) {
    final query = {
      "verifyCode": verifyCode,
    };

    return DioUtil.post(
      ApiPathUtil.delAccount,
      queryParameters: query,
    );
  }

  @override
  sendDelAccountCode() {
    return DioUtil.get(ApiPathUtil.delAccountVerifyCode);
  }

  @override
  retrievePassword(RetrievePasswordDto retrievePasswordDto) {
    return DioUtil.post(ApiPathUtil.retrievePassword,
        data: retrievePasswordDto);
  }

  @override
  sendRetrievePasswordCode(String email) {
    final query = {
      "email": email,
    };
    return DioUtil.get(
      ApiPathUtil.retrieveCodePasswordCode,
      queryParameters: query,
    );
  }
}
