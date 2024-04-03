import 'package:wejinda/business/service_environment/repository/base_url_service.dart';

import '../../../utils/storage_util.dart';

class BaseUrlImpl implements BaseUrlService {
  @override
  String getURL() {
    var baseUrl = GetStorageUtil.readData("BaseUrl");

    if (baseUrl == null || baseUrl == "") {
      baseUrl = "https://singlestep.cn/wejinda";
    }
    return baseUrl;
  }

  @override
  void saveURL(String baseURL) {
    GetStorageUtil.writeData("BaseUrl", baseURL);
  }
}
