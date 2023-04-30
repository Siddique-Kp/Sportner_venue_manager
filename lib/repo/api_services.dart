import 'dart:async';
import 'dart:developer';
import 'package:cloudinary/cloudinary.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'api_status.dart';
import 'service_exeptions.dart';

class ApiServices {
  static Future<Object> postMethod({
    required String url,
    Map<String, String>? headers,
    required body,
    required Function function,
  }) async {
    log(body.toString());
    try {
      final response =
          await http.post(Uri.parse(url), body: body, headers: headers);

      if (response.statusCode == 201 || response.statusCode == 200) {
        log("Success");
        return Success(
          response: function(response.body),
          code: response.statusCode,
        );
      }
      log(response.body.toLowerCase());
      log(response.statusCode.toString());
      return Failure(
        code: response.statusCode,
        errorResponse: "Invalid Response",
      );
    } on Exception catch (e) {
      return ServiceExeptions.cases(e);
    }
  }

  static Future<Object> getMethod(
      {required String url,
      Function? jsonDecod,
      Map<String, String>? headers}) async {
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // log(response.body.toString());

        return Success(
          response: jsonDecod == null ? null : jsonDecod(response.body),
        );
      }
      // log(response.body.toString());

      return Failure(
          code: response.statusCode, errorResponse: "Invalid Response");
    } on Exception catch (e) {
      return ServiceExeptions.cases(e);
    }
  }

  static Future<Object> dioPostMethod({
    required String url,
    String? headers,
    required Object? body,
     Function? function,
  }) async {
    log(body.toString());
    final dio = Dio();
    try {
      dio.options.headers["Authorization"] = headers;
      final response = await dio.post(url, data: body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        log("Success");
        return Success(
          response: function??(response.data),
          code: response.statusCode,
        );
      }
      log(response.data.toLowerCase());
      log(response.statusCode.toString());
      return Failure(
        code: response.statusCode,
        errorResponse: "Invalid Response",
      );
    } on Exception catch (e) {
      return ServiceExeptions.cases(e);
    }
  }
}
