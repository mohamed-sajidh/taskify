import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskify/utils/appColors.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.primaryColor,
                  ),
                ),
                const Text(
                  'Add Task',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.delete,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.secondaryColor,
        centerTitle: false,
      ),
      body: Container(),
    );
  }
}
