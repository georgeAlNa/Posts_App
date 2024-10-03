import 'package:clean_architecture/core/constant/link.dart';
import 'package:clean_architecture/features/posts/data/models/posts_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/classes/crud_dio.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostsModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostsModel post);
  Future<Unit> addPost(PostsModel post);
}

class PostsRemoteDataSourceImp implements PostsRemoteDataSource {
  final CrudDio dio;

  PostsRemoteDataSourceImp({required this.dio});

  @override
  Future<List<PostsModel>> getAllPosts() async {
    final response = await dio.dioGetMethod(
      endPoint: AppLinkUrl.posts,
    );
    List<PostsModel> postModel = response.fold(
      (l) => [],
      (r) {
        return r.map((postModel) => PostsModel.fromJson(postModel)).toList();
      },
    );
    return postModel;
  }

  @override
  Future<Unit> addPost(PostsModel post) async {
    await dio.dioPostMethod(
      endPoint: AppLinkUrl.posts,
      data: {
        'title': post.title,
        'body': post.body,
      },
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> updatePost(PostsModel post) async {
    await dio.dioPatchMethod(
      endPoint: '${AppLinkUrl.posts}/${post.id}',
      data: {
        'title': post.title,
        'body': post.body,
      },
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> deletePost(int id) async {
    await dio.dioDeleteMethod(
      endPoint: '${AppLinkUrl.posts}/$id',
    );
    return Future.value(unit);
  }
}
