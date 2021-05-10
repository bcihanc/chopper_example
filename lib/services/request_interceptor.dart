import 'dart:async';

import 'package:chopper/chopper.dart';

class MyRequestInterceptor extends RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    // check connectivity
    return request;
  }
}