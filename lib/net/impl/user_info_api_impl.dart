import 'package:dio/dio.dart' as dio;
import 'package:wejinda/bean/to/user/app_user_dto.dart';
import 'package:wejinda/net/api/user_info_api.dart';
import 'package:wejinda/net/base/base_api.dart';
import 'package:wejinda/utils/api_path_util.dart';

class UserInfoApiImpl implements UserInfoApi {
  @override
  dynamic sendRegisterCode(String email) {
    final query = {
      "email": email,
    };
    return BaseApiService.ableBaseUrlDio.get(
      ApiPathUtil.userRegisterCode,
      queryParameters: query,
    );
  }

  @override
  dynamic uploadUserAvatarImg(String email, dio.FormData fromDate) {
    final query = {
      "email": email,
    };
    return BaseApiService.ableBaseUrlDio.post(
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

    return BaseApiService.ableBaseUrlDio.post(
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
    return BaseApiService.ableBaseUrlDio.post(
      ApiPathUtil.userLogin,
      data: body,
    );
  }

  @override
  userLogout() {
    // TODO: implement userLogout
    throw UnimplementedError();
  }

  @override
  userLogoutCode() {
    // TODO: implement userLogoutCode
    throw UnimplementedError();
  }

  @override
  userUpdate(AppUserDTO appUserDTO) {
    return BaseApiService.ableBaseUrlDio
        .post(ApiPathUtil.userUpdate, data: appUserDTO);
  }

  @override
  getUserAvatarByEmail(String email) {
    final query = {
      "email": email,
    };

    return BaseApiService.ableBaseUrlDio.post(
      ApiPathUtil.getUserAvatarByEmail,
      queryParameters: query,
    );
  }
}
