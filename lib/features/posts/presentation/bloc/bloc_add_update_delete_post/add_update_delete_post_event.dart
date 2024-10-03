part of 'add_update_delete_post_bloc.dart';

sealed class AddUpdateDeletePostEvent extends Equatable {
  const AddUpdateDeletePostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddUpdateDeletePostEvent {
  final PostsEntity addPost;
  const AddPostEvent({required this.addPost});

  @override
  List<Object> get props => [addPost];
}

class UpdatePostEvent extends AddUpdateDeletePostEvent {
  final PostsEntity updatePost;
  const UpdatePostEvent({required this.updatePost});

  @override
  List<Object> get props => [updatePost];
}

class DeletePostEvent extends AddUpdateDeletePostEvent {
  final int postId;
  const DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
