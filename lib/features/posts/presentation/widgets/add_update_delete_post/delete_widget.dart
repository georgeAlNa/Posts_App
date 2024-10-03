import 'package:clean_architecture/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc_add_update_delete_post/add_update_delete_post_bloc.dart';

class BuildDeleteWidget extends StatelessWidget {
  final int id;
  const BuildDeleteWidget({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Sure Want Delete This Post ?',
        style: TextStyle(
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            BlocProvider.of<AddUpdateDeletePostBloc>(context)
                .add(DeletePostEvent(postId: id));
          },
          child: const Text(
            'Delete',
            style: TextStyle(
              color: AppColors.redColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
