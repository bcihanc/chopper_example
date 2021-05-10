import 'package:chopper/chopper.dart';

class MyErrorConverter extends ErrorConverter {
  @override
  Response convertError<BodyType, InnerType>(Response response) {
    final errorResponse = response.copyWith(bodyError: response.statusCode.toString());
    return errorResponse;
  }
}
