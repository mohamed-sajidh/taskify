import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskify/controller/AddTaskController.dart';
import 'package:taskify/utils/appColors.dart';

class SingleTask extends StatelessWidget {
  final Map<String, dynamic> task;
  final int index;
  const SingleTask({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    final AddtaskController addtaskController = Get.put(AddtaskController());
    return InkWell(
      onTap: () {
        addtaskController.getTaskById(task['id']);
      },
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Obx(() {
                return Checkbox(
                  checkColor: AppColors.white,
                  value: addtaskController.isCheckedList[index],
                  onChanged: (bool? value) {
                    addtaskController.toggleCheckbox(index);
                  },
                  activeColor: AppColors.containerColor,
                  side: const BorderSide(color: AppColors.white, width: 1),
                );
              }),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task['task'] ?? "No Title",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        task['complete_date'] ?? "No Date",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        task['complete_time'] ?? "No Time",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
