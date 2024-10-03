import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors.dart';
import '../../bloc/bloc_add_update_delete_post/add_update_delete_post_bloc.dart';
import '../../screens/posts_screen/posts_screen.dart';
import '../posts_snackbar_widget.dart';

class MyBlocConsumer extends StatelessWidget {
  final Widget loadingShape;

  final Widget widget;

  const MyBlocConsumer({
    super.key,
    required this.loadingShape,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
      listener: (context, state) {
        if (state is SuccessAddOrUpdateOrDeleteState) {
          showSnackBar(
            title: state.message,
            color: AppColors.greenColor,
            context: context,
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const PostsScreen(),
            ),
            (route) => false,
          );
        } else if (state is ErrorAddOrUpdateOrDeleteState) {
          showSnackBar(
            title: state.message,
            color: AppColors.redColor,
            context: context,
          );
          Navigator.of(context).pop;
        }
      },
      builder: (context, state) {
        if (state is LoadingAddOrUpdateOrDeleteState) {
          return loadingShape;
        }
        return widget;
      },
    );
  }
}
