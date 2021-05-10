// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$JsonPlaceHolderService extends JsonPlaceHolderService {
  _$JsonPlaceHolderService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = JsonPlaceHolderService;

  Future<Response<TodoModel>> getTodo(String id) {
    final $url = 'https://jsonplaceholder.typicode.com/todos/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<TodoModel, TodoModel>($request);
  }

  Future<Response<PostModel>> getPost(String id) {
    final $url = 'https://jsonplaceholder.typicode.com/posts/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<PostModel, PostModel>($request);
  }

  Future<Response<List<PostModel>>> getPosts() {
    final $url = 'https://jsonplaceholder.typicode.com/posts';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<PostModel>, PostModel>($request);
  }
}
