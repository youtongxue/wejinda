import 'package:wejinda/net/base/base_api.dart';
import 'package:wejinda/utils/api_path_util.dart';

import '../api/app_info_api.dart';

class AppInfoApiImpl implements AppInfoApi {
  @override
  getAppInfo() {
    return BaseApiService.ableBaseUrlDio.get(ApiPathUtil.appInfo);
  }
}
