import 'package:clean_architecture/features/posts/domain/entities/posts_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/colors.dart';
import '../../widgets/add_update_delete_post/post_details_and_buttons_widget.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostsEntity posts;
  const PostDetailsScreen({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    var mediaData = MediaQuery.of(context).size;
    var height = mediaData.height;
    var width = mediaData.width;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(
        height: height,
        width: width,
        title: posts.title,
        body: posts.body,
        id: posts.id!,
      ),
    );
  }
}

AppBar _buildAppBar() {
  return AppBar(
    iconTheme: const IconThemeData(
      color: AppColors.whiteColor,
    ),
    title: const Text(
      'Post Details',
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
  required String title,
  required String body,
  required int id,
}) {
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.all(8),
    child: BuildPostDetailsAndButtons(
      title: title,
      body: body,
      id: id,
    ),
  );
}
