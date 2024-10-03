import 'dart:convert';

import 'package:clean_architecture/core/constant/shared_pref_name.dart';
import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/posts_model.dart';

abstract class PostsLocalDataSource {
  Future<List<PostsModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostsModel> postsModel);
}

class PostsLocalDataSourceImp implements PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImp({
    required this.sharedPreferences,
  });

  @override
  Future<Unit> cachePosts(List<PostsModel> postsModel) {
    List postsModelToJson = postsModel
        .map<Map<String, dynamic>>(
          (postModel) => postModel.mapToEntity(),
        )
        .toList();
    sharedPreferences.setString(
        AppSharedPrefName.cachePosts, json.encode(postsModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostsModel>> getCachedPosts() {
    var cachedPosts = sharedPreferences.getString(AppSharedPrefName.cachePosts);
    if (cachedPosts != null) {
      List jsonToPostModel = json.decode(cachedPosts);
      List<PostsModel> jsonPostModel = jsonToPostModel
          .map<PostsModel>(
            (postModel) => PostsModel.fromJson(postModel),
          )
          .toList();
      return Future.value(jsonPostModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
