import 'package:flutter/material.dart';

class BuildTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;
  final int minLines;
  final String? hintText;
  const BuildTextFormField({
    super.key,
    required this.controller,
    required this.maxLines,
    required this.minLines,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => value!.isEmpty ? 'Cant Be Empty' : null,
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
