part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

class LoadingPostsState extends PostsState {}

class SuccessPostsState extends PostsState {
  final List<PostsEntity> postsEntity;
  const SuccessPostsState({required this.postsEntity});

  @override
  List<Object> get props => [postsEntity];
}

class FailurePostsState extends PostsState {
  final String message;
  const FailurePostsState({required this.message});

  @override
  List<Object> get props => [message];
}
