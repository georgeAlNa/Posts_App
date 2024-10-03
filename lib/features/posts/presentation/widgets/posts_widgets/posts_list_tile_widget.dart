import 'package:flutter/material.dart';

import '../../../../../core/constant/colors.dart';

class PostsListTile extends StatelessWidget {
  final String leadingText;
  final String title;
  final String subTitle;
  final void Function() onTap;

  const PostsListTile({
    super.key,
    required this.leadingText,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Text(
        leadingText,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.blackColor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(
          color: AppColors.blackColor,
          fontSize: 13,
        ),
      ),
    );
  }
}
