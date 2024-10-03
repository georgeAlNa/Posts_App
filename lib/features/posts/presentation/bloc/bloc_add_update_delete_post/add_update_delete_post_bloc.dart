import 'package:clean_architecture/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constant/const_strings.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entities/posts_entity.dart';
import '../../../domain/usecases/add_post_usecase.dart';
import '../../../domain/usecases/update_post_usecase.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  final AddPostUsecase addPostUsecase;
  final UpdatePostUsecase updatePostUsecase;
  final DeletePostUsecase deletePostUsecase;

  AddUpdateDeletePostBloc({
    required this.addPostUsecase,
    required this.updatePostUsecase,
    required this.deletePostUsecase,
  }) : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddOrUpdateOrDeleteState());

        final failureOrDone = await addPostUsecase.call(event.addPost);

        emit(_failureOrDoneToState(failureOrDone, addPostSuccessString));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddOrUpdateOrDeleteState());

        final failureOrDone = await updatePostUsecase.call(event.updatePost);

        emit(_failureOrDoneToState(failureOrDone, updatePostSuccessString));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddOrUpdateOrDeleteState());

        final failureOrDone = await deletePostUsecase.call(event.postId);

        emit(_failureOrDoneToState(failureOrDone, deletePostSuccessString));
      }
    });
  }
}

AddUpdateDeletePostState _failureOrDoneToState(
    Either<Failure, Unit> either, String message) {
  return either.fold(
    (failure) =>
        ErrorAddOrUpdateOrDeleteState(message: _failureMessage(failure)),
    (addOrUpdateOrDelete) => SuccessAddOrUpdateOrDeleteState(message: message),
  );
}

String _failureMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure():
      return serverFailureString;
    case OfflineFailure():
      return offlineFailureString;
    default:
      return defaultMessageFailureString;
  }
}
