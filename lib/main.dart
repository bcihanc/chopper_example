import 'package:chopper_example/controllers/posts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

void main() {
  // chopper logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Center(child: MyConsumerWidget()),
      ),
    );
  }
}

class MyConsumerWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final provider = watch(PostsController.provider);

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                context.read(PostsController.provider.notifier).getPosts();
              },
              child: Text('bvas')),
          provider.toWidget((posts) {
            return Expanded(
              child: ListView(
                children: posts
                    .map((post) => ListTile(
                          title: Text('${post.title}'),
                        ))
                    .toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}

extension AsyncValueX<T> on AsyncValue<T> {
  Widget toWidget(Widget Function(T data) data, {Widget loading, Function(Object error, StackTrace stack) error}) {
    return this.when(
        data: (_data) => data?.call(_data) ?? const SizedBox.shrink(),
        loading: () => loading ?? const CircularProgressIndicator(),
        error: (_error, _stack) => error?.call(_error, _stack) ?? ErrorWidget(_error));
  }
}
