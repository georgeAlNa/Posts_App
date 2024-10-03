import 'package:clean_architecture/features/posts/domain/entities/posts_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<PostsEntity>>> getAllposts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(PostsEntity post);
  Future<Either<Failure, Unit>> addPost(PostsEntity post);
}
