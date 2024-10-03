import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/posts_entity.dart';
import '../repositories/posts_repository.dart';

class GetAllPostsUsecase {
  final PostsRepository repository;
  GetAllPostsUsecase(this.repository);

  Future<Either<Failure, List<PostsEntity>>> call() async {
    return await repository.getAllposts();
  }
}
