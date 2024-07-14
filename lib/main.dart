import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wabiz_mvvm/view_model/post_view_model.dart';

void main() {
  runApp(
    ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            // final viewModel = ref.read(postViewModelProvider);
            // final posts = ref.watch(fetchPostsProvider);
            // final posts = ref.watch(fetchPostsProvider2);
            // final posts = ref.watch(asyncPostAsyncNotifier);
            final posts = ref.watch(asyncPostsGenNotifierProvider);
            return posts.when(
              data: (data) {
                return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        '${data?[index].id}',
                      ),
                      subtitle: Text(
                        '${data?[index].title}',
                      ),
                    );
                  },
                );
              },
              error: (error, trace) {
                return Text('$error');
              },
              loading: () {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            );
            // return switch (posts) {
            //   AsyncData(:final value) => ListView.builder(
            //       itemCount: value?.length,
            //       itemBuilder: (context, index) {
            //         return ListTile(
            //           title: Text(
            //             '${value?[index].id}',
            //           ),
            //           subtitle: Text(
            //             '${value?[index].title}',
            //           ),
            //         );
            //       },
            //     ),
            //   AsyncError(:final error) => Text('$error'),
            //   _ => Center(
            //       child: CircularProgressIndicator.adaptive(),
            //     ),
            // };
            // return FutureBuilder(
            //   future: viewModel.getPosts(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       final value = snapshot.data ?? [];
            //       if (value.isEmpty) {
            //         return Center(
            //           child: Text('아이템이 없습니다.'),
            //         );
            //       }
            //       return ListView.builder(
            //         itemCount: value.length,
            //         itemBuilder: (context, index) {
            //           return ListTile(
            //             title: Text(
            //               '${value[index].id}',
            //             ),
            //             subtitle: Text(
            //               '${value[index].title}',
            //             ),
            //           );
            //         },
            //       );
            //     }
            //     return Center(
            //       child: CircularProgressIndicator.adaptive(),
            //     );
            //   },
            // );
          },
        ),
      ),
    );
  }
}
