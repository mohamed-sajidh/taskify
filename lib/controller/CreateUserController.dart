import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taskify/utils/appColors.dart';
import 'package:taskify/view/auth_screens/login_screen.dart';

class CreateUserController extends GetxController {
  RxBool isLoading = false.obs;

  Future<User?> registerUser(String email, String password) async {
    try {
      isLoading.value = true; // ✅ Use `.value`

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // ✅ Only navigate if user is created
        Get.to(() => const LoginScreen());
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
      // Handle specific Firebase errors
      if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Error',
          'This email is already registered',
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
        print("Error: This email is already registered.");
      } else if (e.code == 'weak-password') {
        Get.snackbar(
          'Error',
          'The password is too weak.',
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
        print("Error: The password is too weak.");
      } else {
        print("Error: ${e.message}");
      }
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
