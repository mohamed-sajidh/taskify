import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskify/controller/AddTaskController.dart';
import 'package:taskify/controller/HomeController.dart';
import 'package:taskify/utils/appColors.dart';
import 'package:taskify/view/home/add_task.dart';
import 'package:taskify/view/home/single_task.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final AddtaskController addtaskController = Get.put(AddtaskController());
    

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home page',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25, right: 8, left: 8),
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: homeController.getUserTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No tasks available",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              );
            }

            final tasks = snapshot.data!;
            addtaskController.initializeTasks(tasks.length);

            return ListView.separated(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return SingleTask(
                  task: task,
                  index: index,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            );
          },
        ),
      ),
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => const AddTask(task: {},));
          },
          backgroundColor: AppColors.containerColor,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            size: 40,
            color: AppColors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
