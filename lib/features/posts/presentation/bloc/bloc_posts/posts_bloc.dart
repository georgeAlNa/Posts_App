import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture/features/posts/domain/entities/posts_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constant/const_strings.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPosts;
  PostsBloc({
    required this.getAllPosts,
  }) : super(PostsInitial()) {
    on<PostsEvent>(
      (event, emit) async {
        if (event is GetAllPostsEvent) {
          emit(LoadingPostsState());
          final failureOrPosts = await getAllPosts.call();
          //! To avoid repetition
          emit(_failureOrPostsToState(failureOrPosts));
          // failureOrPosts.fold(
          //   (failure) {
          //     emit(FailurePostsState(message: _failureMessage(failure)));
          //   },
          //   (posts) {
          //     emit(SuccessPostsState(postsEntity: posts));
          //   },
          // );
        } else if (event is RefreshPostsEvent) {
          emit(LoadingPostsState());
          final failureOrPosts = await getAllPosts.call();
          //! To avoid repetition
          emit(_failureOrPostsToState(failureOrPosts));
          // failureOrPosts.fold(
          //   (failure) {
          //     emit(FailurePostsState(message: _failureMessage(failure)));
          //   },
          //   (posts) {
          //     emit(SuccessPostsState(postsEntity: posts));
          //   },
          // );
        }
      },
    );
  }
}

PostsState _failureOrPostsToState(Either<Failure, List<PostsEntity>> either) {
  return either.fold(
    (failure) => FailurePostsState(message: _failureMessage(failure)),
    (posts) => SuccessPostsState(postsEntity: posts),
  );
}

String _failureMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure():
      return serverFailureString;
    case OfflineFailure():
      return offlineFailureString;
    case EmptyCacheFailure():
      return emptyCacheFailureString;
    default:
      return defaultMessageFailureString;
  }
}
