import 'dart:async';
import 'dart:developer';
import 'dart:io';
import '../../utils/constants.dart';
import 'api_status.dart';

class ServiceExeptions {
  static Object cases(Exception e) {
    log(e.runtimeType.toString());
    switch (e.runtimeType) {
      case HttpException:
        return Failure(
          code: InvalidRespons.kNOINTERNET,
          errorResponse: "No internet",
        );

      case FormatException:
        return Failure(
          code: InvalidRespons.kINVALIDFORMAT,
          errorResponse: "Invalid Format",
        );

      case SocketException:
        return Failure(
          code: InvalidRespons.kNOINTERNET,
          errorResponse: "No internet",
        );

      case TimeoutException:
        return Failure(
          code: InvalidRespons.kTIMEOUT,
          errorResponse: "Time out try again",
        );

      default:
        return Failure(
          code: InvalidRespons.kUNKNOWNERROR,
          errorResponse: "Unknown Error",
        );
    }
  }
}
