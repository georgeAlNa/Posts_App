import 'package:clean_architecture/core/public%20widgets/loading_widget.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/add_update_delete_post/delete_widget.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/add_update_delete_post/my_bloc_consumer.dart';
import 'package:flutter/material.dart';

void buildAlertDialog({
  required BuildContext context,
  required int id,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return MyBlocConsumer(
        loadingShape: const AlertDialog(
              title: LoadingWidget(),
            ),
        widget: BuildDeleteWidget(id: id),
      );
    },
  );
}
