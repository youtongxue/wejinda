import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:wejinda/utils/api_path_util.dart';

enum DioConfig {
  ableBaseUrl(key: "ableBaseUrl"),
  enableBaseUrl(key: "enableBaseUrl"),
  loginedBaseUrl(key: "loginedBaseUrl");

  final String key;

  const DioConfig({
    required this.key,
  });
}

class DioUtil {
  static late Dio _dio;
  late BaseOptions _baseOptions;
  static final Map<DioConfig, DioUtil> _dioMap = {};

  // dio初始化配置 https://github.com/cfug/dio/blob/main/dio/README-ZH.md -> 【请求配置】
  DioUtil._ableBaseUrl() {
    debugPrint("初始化Dio, 带BASE_URL > > > ${ApiPathUtil.getSpringBootBaseUrl()}");
    _baseOptions = BaseOptions(
        //baseUrl: ApiPathUtil.springBootBaseUrl,
        baseUrl: ApiPathUtil.getSpringBootBaseUrl(),
        contentType: Headers.jsonContentType);
    _dio = Dio(_baseOptions);
  }

  DioUtil._enableBaseUrl() {
    debugPrint("初始化Dio, 不带BASE_URL");
    _dio = Dio();
  }

  DioUtil._loginedBaseUrl(String loginToken) {
    debugPrint("初始化Dio, 带BASE_URL、添加拦截器注入loginToken");
    _baseOptions = BaseOptions(
        //baseUrl: ApiPathUtil.springBootBaseUrl,
        baseUrl: ApiPathUtil.getSpringBootBaseUrl(),
        contentType: Headers.jsonContentType);
    _dio = Dio(_baseOptions);

    // 添加拦截器
    _dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      var customHeaders = {'loginToken': loginToken};
      options.headers.addAll(customHeaders);
      return handler.next(options); // continue
    }));
  }

  static DioUtil getDio(DioConfig dioConfig, {String? loginToken}) {
    if (!_dioMap.containsKey(dioConfig)) {
      if (dioConfig == DioConfig.ableBaseUrl) {
        _dioMap[dioConfig] = DioUtil._ableBaseUrl();
      } else if (dioConfig == DioConfig.enableBaseUrl) {
        _dioMap[dioConfig] = DioUtil._enableBaseUrl();
      } else if (dioConfig == DioConfig.loginedBaseUrl) {
        _dioMap[dioConfig] = DioUtil._loginedBaseUrl(loginToken!);
      }
    }

    return _dioMap[dioConfig]!;
  }

  // get请求
  Future<dynamic> get(url,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    debugPrint(
        '< < <   get请求   > > > \n------ path:$url \n-------query 请求头信息:$options \n-------url 请求参数:$queryParameters \n-------body 请求参数:$data');
    try {
      Response response = await _dio.get(url,
          data: data, queryParameters: queryParameters, options: options);
      debugPrint('< < <   get结果   > > > \n------ result: ${response.data}');
      return response;
    } on DioException catch (e) {
      debugPrint(
          '< < <   get请求失败   > > > \n------ 错误类型:\n${e.type} \n------ 错误信息:\n${e.message}');
      return e;
    }
  }

  // Post请求
  Future<dynamic> post(url,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    debugPrint(
        '< < <   post请求   > > > \n------ path:$url \n-------query 请求头信息:$options \n-------url 请求参数:$queryParameters \n-------body 请求参数:$data');
    try {
      Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      debugPrint('< < <   post结果   > > > \n------ result:${response.data}');
      return response;
    } on DioException catch (e) {
      debugPrint(
          '< < <   post请求失败   > > > \n------ 错误类型:\n${e.type} \n------ 错误信息:\n${e.message}');
      return e;
    }
  }
}
