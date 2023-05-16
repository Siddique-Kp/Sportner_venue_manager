import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloudinary/cloudinary.dart';

import '../utils/constants.dart';
import 'api_status.dart';

class ServiceExeptions {
  static cases(Exception e) {
    if (e is HttpException) {
      log("HttpException");
      return Failure(
        code: InvalidRespons.kNOINTERNET,
        errorResponse: "No internet connection",
      );
    } else if (e is FormatException) {
      log("FormatException");

      return Failure(
        code: InvalidRespons.kINVALIDFORMAT,
        errorResponse: "Invalid Format",
      );
    } else if (e is SocketException) {
      return Failure(
        code: InvalidRespons.kNOINTERNET,
        errorResponse: "No internet connection",
      );
    } else if (e is DioError) {
      log(e.toString());
      log("SocketException Dio");
      return Failure(
        code: InvalidRespons.kNOINTERNET,
        errorResponse: "No internet connection",
      );
    } else if (e is TimeoutException) {
      log("TimeoutException");

      return Failure(
        code: InvalidRespons.kTIMEOUT,
        errorResponse: "Time out try again",
      );
    } else {
      log("Failure");
      return Failure(
        code: InvalidRespons.kUNKNOWNERROR,
        errorResponse: "Unknown Error",
      );
    }
  }
}
