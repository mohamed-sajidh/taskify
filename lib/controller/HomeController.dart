import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUserTasks() {
    try {
      isLoading.value = true;
      User? user = auth.currentUser;

      if (user != null) {
        String uid = user.uid;

        return firestore
            .collection('users')
            .doc(uid)
            .collection('tasks')
            .where('isCompleted', isEqualTo: false)
            .snapshots()
            .map((querySnapshot) {
          return querySnapshot.docs.map((doc) {
            return {
              'id': doc.id, // Document ID
              ...doc.data(), // Task Data
            };
          }).toList();
        });
      } else {
        return const Stream.empty();
      }
    } catch (e) {
      print("Error fetching tasks: $e");
      return const Stream.empty();
    } finally {
      isLoading.value = false;
    }
  }
}
