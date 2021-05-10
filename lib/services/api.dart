import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:chopper_example/models/post_model.dart';
import 'package:chopper_example/models/todo_model.dart';

part 'api.chopper.dart';

@ChopperApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class JsonPlaceHolderService extends ChopperService {
  static JsonPlaceHolderService create([ChopperClient client]) => _$JsonPlaceHolderService(client);

  @Get(path: "/todos/{id}")
  Future<Response<TodoModel>> getTodo(@Path("id") String id);

  @Get(path: "/posts/{id}")
  Future<Response<PostModel>> getPost(@Path("id") String id);

  @Get(path: "/posts")
  Future<Response<List<PostModel>>> getPosts();
}

