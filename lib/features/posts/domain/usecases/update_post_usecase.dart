import 'package:clean_architecture/features/posts/domain/entities/posts_entity.dart';
import 'package:clean_architecture/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class UpdatePostUsecase {
  final PostsRepository repository;
  UpdatePostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(PostsEntity post) async {
    return await repository.updatePost(post);
  }
}
