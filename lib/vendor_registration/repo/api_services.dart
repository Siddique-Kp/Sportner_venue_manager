import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'api_status.dart';
import 'service_exeptions.dart';

class ApiServices {
  static Future<Object> postMethod(
    String url,
    Map body,
    Function function,
  ) async {
    log(body.toString());
    try {
      final response = await http.post(Uri.parse(url), body: body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        log("Success");
        return Success(response: function(response.body));
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
}
