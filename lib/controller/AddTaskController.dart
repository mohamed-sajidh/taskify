import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taskify/utils/appColors.dart';
import 'package:taskify/view/home/add_task.dart';
import 'package:taskify/view/home/home_page.dart';

class AddtaskController extends GetxController {
  RxBool isLoading = false.obs;
  var isCheckedList = <bool>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void initializeTasks(int length) {
    isCheckedList.assignAll(List.generate(length, (index) => false));
  }

  void toggleCheckbox(int index) {
    isCheckedList[index] = !isCheckedList[index];
  }

  Future<void> addTask(String title, String date, String time) async {
    try {
      isLoading.value = true;
      User? user = auth.currentUser;

      if (user != null) {
        String uid = user.uid;

        /// Add a new document to the `tasks` collection inside the user's document.
        await firestore.collection('users').doc(uid).collection('tasks').add({
          'task': title,
          'complete_date': date,
          'complete_time': time,
          'timestamp': FieldValue.serverTimestamp(),
          'isCompleted': true,
        });

        Get.snackbar(
          'Success',
          'Task added successfully',
          backgroundColor: AppColors.green,
          colorText: AppColors.white,
        );

        Get.to(() => const HomePage());
      } else {
        Get.snackbar(
          'Error',
          'User not logged in',
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
      }
    } catch (e) {
      print("Error adding task: $e");
      Get.snackbar(
        'Error',
        'Failed to add task',
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('tasks')
            .doc(taskId)
            .delete();

        print("Task deleted successfully");
      }
    } catch (e) {
      print("Error deleting task: $e");
    }
  }

  Future<Map<String, dynamic>?> getTaskById(String taskId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;

        DocumentSnapshot taskSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('tasks')
            .doc(taskId)
            .get();

        if (taskSnapshot.exists) {
          Map<String, dynamic> taskData = {
            'id': taskSnapshot.id, // Document ID
            ...taskSnapshot.data() as Map<String, dynamic>, // Task Data
          };

          Get.to(() => AddTask(task: taskData)); // Pass task data to AddTask
          return taskData;
        }
      }
    } catch (e) {
      print("Error fetching task: $e");
    }
    return null;
  }

  Future<void> updateTask(
      String taskId, String taskName, String dueDate, String dueTime) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('tasks')
            .doc(taskId)
            .update({
          'taskName': taskName,
          'dueDate': dueDate,
          'dueTime': dueTime,
        });

        Get.snackbar('Success', 'Task updated successfully!');
      }
    } catch (e) {
      print("Error updating task: $e");
      Get.snackbar('Error', 'Failed to update task.');
    }
  }
}
