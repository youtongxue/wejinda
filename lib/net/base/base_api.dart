import '../../utils/dio_util.dart';

class BaseApiService {
  static DioUtil ableBaseUrlDio = DioUtil.getDio(DioConfig.ableBaseUrl);
  static DioUtil enableBaseUrlDio = DioUtil.getDio(DioConfig.enableBaseUrl);
}
