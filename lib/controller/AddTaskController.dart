import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taskify/utils/appColors.dart';

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
        });

        Get.snackbar(
          'Success',
          'Task added successfully',
          backgroundColor: AppColors.green,
          colorText: AppColors.white,
        );
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


  
}
