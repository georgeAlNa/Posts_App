import 'package:clean_architecture/core/classes/network_info.dart';
import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/posts/data/datasources/posts_local_data_source.dart';
import 'package:clean_architecture/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:clean_architecture/features/posts/data/models/posts_model.dart';
import 'package:clean_architecture/features/posts/domain/entities/posts_entity.dart';
import 'package:clean_architecture/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class PostsRepositoryImp implements PostsRepository {
  final PostsRemoteDataSource postsRemoteDataSource;
  final PostsLocalDataSource postsLocalDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImp({
    required this.postsRemoteDataSource,
    required this.postsLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostsEntity>>> getAllposts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postsRemoteDataSource.getAllPosts();
        final postsEntities =
            remotePosts.map((postModel) => postModel.toEntity()).toList();

        postsLocalDataSource.cachePosts(remotePosts);
        return Right(postsEntities);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postsLocalDataSource.getCachedPosts();
        final postsEntity =
            localPosts.map((postModel) => postModel.toEntity()).toList();
        return Right(postsEntity);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostsEntity post) async {
    final PostsModel postsModel = PostsModel(
      title: post.title,
      body: post.body,
    );
    return await _getMessage(
      () {
        return postsRemoteDataSource.addPost(postsModel);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(
      () {
        return postsRemoteDataSource.deletePost(postId);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostsEntity post) async {
    final PostsModel postsModel = PostsModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getMessage(
      () {
        return postsRemoteDataSource.updatePost(postsModel);
      },
    );
  }

  Future<Either<Failure, Unit>> _getMessage(
    Future<Unit> Function() deleteOrUpdateOrAddPost,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        deleteOrUpdateOrAddPost;
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
