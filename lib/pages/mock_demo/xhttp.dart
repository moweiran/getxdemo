import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:getxdemo/pages/mock_demo/mock_datas.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class XHttp {
  XHttp._();

  ///网络请求配置
  static late Dio dio;
  static late DioAdapter _adapter;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://dev-api.joinfud.com',
      connectTimeout: 20000,
      sendTimeout: 20000,
      receiveTimeout: 20000,
    ));

    dio.interceptors
        .add(InterceptorsWrapper(onResponse: (Response response, handler) {
      debugPrint("请求${response.realUri} ${json.encode(response.data)}=====");
      return handler.next(response);
    }));

    /// mock
    if (kDebugMode) {
      _adapter = DioAdapter(
        dio: dio,
        matcher: const FullHttpRequestMatcher(),
      );
    }
  }

  ///post body请求
  static Future postJson(String url, [Map<String, dynamic>? data]) async {
    debugPrint('=============++++=============$url $data=+++++++++++++');
    if (kDebugMode) {
      _adapter.onPost(
        url,
        (server) => server.reply(
          200,
          MockDatas.mockApiJsonDatas[url],
          // Reply would wait for one-sec before returning data.
          delay: const Duration(seconds: 1),
        ),
        data: data,
      );
    }
    Response response = await dio.post(url, data: data);
    return response.data;
  }
}
