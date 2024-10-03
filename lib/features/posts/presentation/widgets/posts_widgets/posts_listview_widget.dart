import 'package:flutter/material.dart';

import '../../../../../core/constant/colors.dart';
import '../../../domain/entities/posts_entity.dart';
import '../../screens/update_add_delete_post_screen/post_details.dart';
import 'posts_list_tile_widget.dart';

class PostsListviewWidget extends StatelessWidget {
  final List<PostsEntity> posts;
  // final void Function() onTap;
  const PostsListviewWidget({
    super.key,
    required this.posts,
    // required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostsListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailsScreen(
                  posts: posts[index],
                ),
              ),
            );
          },
          leadingText: posts[index].id.toString(),
          title: posts[index].title.toString(),
          subTitle: posts[index].body.toString(),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: AppColors.greyColor,
          thickness: 1,
        );
      },
    );
  }
}
