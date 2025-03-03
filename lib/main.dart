import 'package:flutter/material.dart';
import 'package:taskify/utils/appColors.dart';
import 'package:taskify/view/auth_screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
