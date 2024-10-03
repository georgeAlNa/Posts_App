import 'package:clean_architecture/core/public%20widgets/loading_widget.dart';
import 'package:clean_architecture/features/posts/presentation/screens/update_add_delete_post_screen/add_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors.dart';
import '../../bloc/bloc_posts/posts_bloc.dart';
import '../../widgets/posts_snackbar_widget.dart';
import '../../widgets/posts_widgets/posts_listview_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaData = MediaQuery.of(context).size;
    var height = mediaData.height;
    var width = mediaData.width;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(height: height, width: width),
      floatingActionButton: _buildFloatingActionButton(context: context),
    );
  }
}

AppBar _buildAppBar() {
  return AppBar(
    title: const Text(
      'Posts',
      style: TextStyle(
        color: AppColors.whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    backgroundColor: AppColors.primaryColor,
  );
}

Widget _buildBody({
  required dynamic height,
  required dynamic width,
}) {
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.all(1),
    child: _buildBlocBuilder(),
  );
}

Widget _buildFloatingActionButton({required BuildContext context}) {
  return Container(
    height: 60,
    width: 60,
    decoration: const BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    child: IconButton(
      icon: const Icon(Icons.add),
      color: AppColors.whiteColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddPostScreen(),
          ),
        );
      },
    ),
  );
}

Widget _buildBlocBuilder() {
  return BlocBuilder<PostsBloc, PostsState>(
    builder: (context, state) {
      if (state is LoadingPostsState) {
        return const LoadingWidget();
      } else if (state is SuccessPostsState) {
        return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: PostsListviewWidget(
            posts: state.postsEntity,
          ),
        );
      } else if (state is FailurePostsState) {
        showSnackBar(
          title: state.message,
          color: AppColors.redColor,
          context: context,
        );
      }
      return const LoadingWidget();
    },
  );
}

Future<void> _onRefresh(BuildContext context) async {
  BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
}
