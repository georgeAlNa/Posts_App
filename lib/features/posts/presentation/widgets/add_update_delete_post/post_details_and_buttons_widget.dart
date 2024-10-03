import 'package:clean_architecture/features/posts/presentation/widgets/add_update_delete_post/alert_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/colors.dart';

import '../../screens/update_add_delete_post_screen/update_post_screen.dart';
import '../submit_button.dart';

class BuildPostDetailsAndButtons extends StatelessWidget {
  final String title;
  final String body;
  final int id;
  const BuildPostDetailsAndButtons({
    super.key,
    required this.title,
    required this.body,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          body,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SubmitButton(
              title: 'Edit',
              icon: Icons.edit,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdatePostScreen(
                      title: title,
                      body: body,
                      id: id,
                    ),
                  ),
                );
              },
              color: AppColors.primaryColor,
            ),
            SubmitButton(
              title: 'Delete',
              icon: Icons.delete,
              onTap: () {
                buildAlertDialog(
                  context: context,
                  id: id,
                );
              },
              color: AppColors.redColor,
            ),
          ],
        )
      ],
    );
  }
}
