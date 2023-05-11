import 'dart:async';
import 'dart:developer';
import 'package:cloudinary/cloudinary.dart';
import 'package:dio/dio.dart';
import 'api_status.dart';
import 'service_exeptions.dart';

class ApiServices {
  static Future<Object> dioPostMethod({
    required String url,
    required Object? body,
    String? headers,
    Function? jsonEncode,
  }) async {
    log(body.toString());
    final dio = Dio();
    try {
      dio.options.headers["Authorization"] = headers;
      final response = await dio.post(url, data: body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        log("Success");
        return Success(
          response: jsonEncode == null ? null : jsonEncode(response.data),
          code: response.statusCode,
        );
      }
      log(response.data.toString());
      log(response.statusCode.toString());
      return Failure(
        code: response.statusCode,
        errorResponse: "Invalid Response",
      );
    } on Exception catch (e) {
      return ServiceExeptions.cases(e);
    }
  }

  static Future<Object> dioGetMethod({
    required String url,
    Function? jsonDecod,
    String? headers,
  }) async {
    try {
      final dio = Dio();
      dio.options.headers["Authorization"] = headers;
      final response = await dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return Success(
          response: jsonDecod == null ? null : jsonDecod(response.data),
        );
      }

      return Failure(
          code: response.statusCode, errorResponse: "Invalid Response");
    } on Exception catch (e) {
      return ServiceExeptions.cases(e);
    }
  }
}
