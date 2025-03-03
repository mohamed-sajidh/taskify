import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  RxString selectedValue = 'all tasks'.obs;
  Rx<Stream<List<Map<String, dynamic>>>> currentTaskStream =
      Stream<List<Map<String, dynamic>>>.empty().obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void selectedDropList(String value) {
    selectedValue(value);
    fetchTasks();
  }

  void fetchTasks() {
    isLoading.value = true;
    currentTaskStream.value = selectedValue.value == 'all tasks'
        ? getUserTasks()
        : getUserFinishedTasks();
    isLoading.value = false;
  }

  Stream<List<Map<String, dynamic>>> getUserTasks() {
    User? user = auth.currentUser;
    if (user == null) return Stream.value([]);

    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('tasks')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
    }).handleError((error) {
      print("Error fetching tasks: $error");
    });
  }

  Stream<List<Map<String, dynamic>>> getUserFinishedTasks() {
    User? user = auth.currentUser;
    if (user == null) return Stream.value([]);

    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('tasks')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
    }).handleError((error) {
      print("Error fetching finished tasks: $error");
    });
  }
}
