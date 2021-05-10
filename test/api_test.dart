import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:chopper_example/models/post_model.dart';
import 'package:chopper_example/models/todo_model.dart';
import 'package:chopper_example/services/api.dart';
import 'package:chopper_example/services/request_interceptor.dart';
import 'package:chopper_example/services/converters.dart';
import 'package:chopper_example/services/error_converter.dart';

main() async {
  final headers = {"Bearer": "Bearer"};
  final factories = {
    PostModel: (json) => PostModel.fromJson(json),
    TodoModel: (json) => TodoModel.fromJson(json),
  };
  final chopper = ChopperClient(
      services: [
        JsonPlaceHolderService.create()
      ],

      interceptors: [
        // before request
        MyRequestInterceptor(),

        // headers
        HeadersInterceptor(headers),

        // default chopper logging
        HttpLoggingInterceptor(),
      ],

      // error converter
      errorConverter: MyErrorConverter(),

      // json converter factories
      converter: Converters(factories));

  final service = chopper.getService<JsonPlaceHolderService>();
  final todoResponse = await service.getTodo("3");
  final postResponse = await service.getPost("x");

  debugger();
}
