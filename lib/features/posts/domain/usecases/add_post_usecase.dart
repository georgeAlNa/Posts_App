import 'package:clean_architecture/features/posts/domain/entities/posts_entity.dart';
import 'package:clean_architecture/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class AddPostUsecase {
  final PostsRepository repository;
  AddPostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(PostsEntity post) async {
    return await repository.addPost(post);
  }
}
