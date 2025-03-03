import 'package:get/get.dart';

class AddtaskController extends GetxController {
  var isCheckedList = <bool>[].obs;

  void initializeTasks(int length) {
    isCheckedList.assignAll(List.generate(length, (index) => false));
  }

  void toggleCheckbox(int index) {
    isCheckedList[index] = !isCheckedList[index];
  }
}
