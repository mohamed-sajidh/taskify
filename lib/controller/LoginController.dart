import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taskify/utils/appColors.dart';
import 'package:taskify/view/home/home_page.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  Future<User?> loginUser(String email, String password) async {
    try {
      isLoading.value = true; // ✅ Show loading state

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // ✅ Navigate to HomePage after successful login
        Get.offAll(() => const HomePage());
        return userCredential.user;
      } else {
        Get.snackbar(
          'Error',
          'Login failed',
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Error',
          'No user found with this email',
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Error',
          'Incorrect password',
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          e.message ?? 'An unknown error occurred',
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return null;
    } finally {
      isLoading.value = false; // ✅ Hide loading state
    }
  }
}
