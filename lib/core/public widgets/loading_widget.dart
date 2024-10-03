import 'package:clean_architecture/core/constant/colors.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:  Wrap(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: SizedBox(
              height: 30,
              width: 30,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
