import 'package:clean_architecture/core/public%20widgets/loading_widget.dart';
import 'package:clean_architecture/features/posts/presentation/bloc/bloc_add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/add_update_delete_post/my_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors.dart';
import '../../../domain/entities/posts_entity.dart';
import '../../widgets/submit_button.dart';
import '../../widgets/text_field.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  final TextEditingController titleController = TextEditingController();

  final TextEditingController bodyController = TextEditingController();

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

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
        titleController: titleController,
        bodyController: bodyController,
        formKey: formState,
        context: context,
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
      'Add Post',
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
  required TextEditingController titleController,
  required TextEditingController bodyController,
  required GlobalKey<FormState> formKey,
  required BuildContext context,
}) {
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.all(8),
    child: _buildTextFieldsAndButton(
      titleController: titleController,
      bodyController: bodyController,
      formKey: formKey,
      context: context,
    ),
  );
}

Widget _buildTextFieldsAndButton({
  required TextEditingController titleController,
  required TextEditingController bodyController,
  required GlobalKey<FormState> formKey,
  required BuildContext context,
}) {
  return SingleChildScrollView(
    child: Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          BuildTextFormField(
            controller: titleController,
            maxLines: 10,
            minLines: 1,
            hintText: 'Title',
          ),
          const SizedBox(
            height: 30,
          ),
          BuildTextFormField(
            controller: bodyController,
            maxLines: 20,
            minLines: 6,
            hintText: 'Body',
          ),
          const SizedBox(
            height: 30,
          ),
          MyBlocConsumer(
            loadingShape: const LoadingWidget(),
            widget: SubmitButton(
              title: 'Add',
              icon: Icons.add,
              onTap: () {
                final valid = formKey.currentState!.validate();
                final post = PostsEntity(
                  title: titleController.text,
                  body: bodyController.text,
                );
                if (valid) {
                  BlocProvider.of<AddUpdateDeletePostBloc>(context).add(
                    AddPostEvent(addPost: post),
                  );
                }
              },
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    ),
  );
}
