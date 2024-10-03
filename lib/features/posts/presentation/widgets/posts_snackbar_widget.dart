import 'package:clean_architecture/core/constant/colors.dart';
import 'package:flutter/material.dart';

  void showSnackBar({
    required String title,
    required Color color,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          title,
          style: const TextStyle(
            color: AppColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

