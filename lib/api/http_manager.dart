import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/utils/logger.dart';

Map<String, dynamic> dioErrorHandle(DioError error) {
  UtilLogger.log("ERROR", error);

  switch (error.type) {
    case DioErrorType.RESPONSE:
      return error.response?.data;
    case DioErrorType.SEND_TIMEOUT:
    case DioErrorType.RECEIVE_TIMEOUT:
      return {"success": false, "code": "request_time_out"};

    default:
      return {"success": false, "code": "connect_to_server_fail"};
  }
}

class HTTPManager {
  BaseOptions baseOptions = BaseOptions(
    //baseUrl: "http://listar.passionui.com/index.php/wp-json",
 /*   baseUrl: "https://naxosoft.com/projects/listing/index.php/wp-json",*/

    baseUrl: "https://naxosoft.com/projects/itsme4u/api",
    connectTimeout: 10000,
    receiveTimeout: 10000,
    contentType: Headers.formUrlEncodedContentType,
    responseType: ResponseType.json,
  );

  ///Setup Option
  BaseOptions exportOption(BaseOptions options) {
    Map<String, dynamic> header = {
      "Device-Id": Application.device?.uuid,
      "Device-Name": utf8.encode(Application.device?.name ?? ''),
      "Device-Model": Application.device?.model,
      "Device-Version": Application.device?.version,
      "Push-Token": Application.device?.token,
      "Type": Application.device?.type,
      "Lang": AppLanguage.defaultLanguage?.languageCode
    };
    options.headers = Map.from(header);
    if (Application.user?.token != null) {
      options.headers["Authorization"] = "Bearer ${Application.user.token}";
    }
    UtilLogger.log("headers", options.headers);
    return options;
  }

  ///Post method
  Future<dynamic> post({
    String url,
    Map<String, dynamic> data,
    Options options,
  }) async {
    UtilLogger.log("POST URL", url);
    UtilLogger.log("DATA", data);
    Dio dio = new Dio(exportOption(baseOptions));
    try {
      final response = await dio.post(
        url,
        data: data,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return dioErrorHandle(error);
    }
  }

  ///Get method
  Future<dynamic> get({
    String url,
    Map<String, dynamic> params,
    Options options,
  }) async {
    UtilLogger.log("GET URL", url);
    UtilLogger.log("PARAMS", params);
    Dio dio = new Dio(exportOption(baseOptions));
    try {
      final response = await dio.get(
        url,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return dioErrorHandle(error);
    }
  }

  factory HTTPManager() {
    return HTTPManager._internal();
  }

  HTTPManager._internal();
}

HTTPManager httpManager = HTTPManager();
