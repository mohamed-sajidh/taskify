import 'package:flutter/material.dart';
import 'package:taskify/utils/appColors.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          color: AppColors.primaryColor
        ),
      ),
    );
  }
}