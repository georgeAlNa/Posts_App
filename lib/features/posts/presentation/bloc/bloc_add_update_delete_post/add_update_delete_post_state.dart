part of 'add_update_delete_post_bloc.dart';

sealed class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

final class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

class LoadingAddOrUpdateOrDeleteState extends AddUpdateDeletePostState {}

class SuccessAddOrUpdateOrDeleteState extends AddUpdateDeletePostState {
  final String message;
  const SuccessAddOrUpdateOrDeleteState({required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorAddOrUpdateOrDeleteState extends AddUpdateDeletePostState {
  final String message;
  const ErrorAddOrUpdateOrDeleteState({required this.message});

  @override
  List<Object> get props => [message];
}
