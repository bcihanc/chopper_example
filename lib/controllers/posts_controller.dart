import 'package:chopper/chopper.dart';
import 'package:chopper_example/models/post_model.dart';
import 'package:chopper_example/models/todo_model.dart';
import 'package:chopper_example/services/api.dart';
import 'package:chopper_example/services/converters.dart';
import 'package:chopper_example/services/error_converter.dart';
import 'package:chopper_example/services/request_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chopperClientProvider = Provider<ChopperClient>((_) {
  final headers = {"Bearer": "Bearer"};
  final factories = {
    PostModel: (json) => PostModel.fromJson(json),
    TodoModel: (json) => TodoModel.fromJson(json),
  };

  return ChopperClient(
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
});

class PostsController extends StateNotifier<AsyncValue<List<PostModel>>> {
  PostsController(this._reader) : super(AsyncValue.loading());
  final Reader _reader;

  static final provider =
      StateNotifierProvider<PostsController, AsyncValue<List<PostModel>>>((ref) => PostsController(ref.read));

  Future<void> getPosts() async {
    state = AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final chopper = _reader(chopperClientProvider).getService<JsonPlaceHolderService>();
      final response = await chopper.getPosts();
      if (response.isSuccessful) {
        return response.body;
      } else
        throw response.error;
    });
  }
}
