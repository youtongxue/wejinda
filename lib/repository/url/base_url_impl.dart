import 'package:wejinda/repository/url/base_url_service.dart';

import '../../utils/storage_util.dart';

class BaseUrlImpl implements BaseUrlService {
  @override
  String getURL() {
    final baseUrl = GetStorageUtil.readData("BaseUrl");
    return baseUrl ?? "https://singlestep.cn/wejinda";
  }

  @override
  void saveURL(String baseURL) {
    GetStorageUtil.writeData("BaseUrl", baseURL);
  }
}
