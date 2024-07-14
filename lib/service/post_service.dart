import 'package:wabiz_mvvm/model/post_model.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final postRepository = Provider((ref) {
  return PostRepositoryImpl(ref.read(postServiceProvider));
});

final postServiceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return PostServiceImpl(dio);
});

final dioProvider = Provider((ref) {
  return Dio();
});

abstract class PostRepository {
  Future<List<PostModel>?> getPosts();
}

class PostRepositoryImpl extends PostRepository {
  PostServiceImpl postServiceImpl;

  PostRepositoryImpl(this.postServiceImpl);

  @override
  Future<List<PostModel>?> getPosts() async {
    return await postServiceImpl.getPosts();
  }
}

abstract class PostService {
  Future<List<PostModel>?> getPosts();
}

class PostServiceImpl extends PostService {
  Dio dio;

  PostServiceImpl(this.dio);

  @override
  Future<List<PostModel>?> getPosts() async {
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/posts');
    if (response.statusCode == 200) {
      // json array
      List<dynamic> jsonList = response.data;
      List<PostModel> posts =
          jsonList.map((json) => PostModel.fromJson(json)).toList();
      return posts;
    } else {
      return [];
    }
  }
}
