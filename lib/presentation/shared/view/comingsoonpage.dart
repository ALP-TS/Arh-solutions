import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/theme/colors.dart';
import '../../../core/res/assets/images.dart';
// import 'package:sidhartha_central_school/res/assets/Images.dart';
// import 'package:sidhartha_central_school/res/colors/app_colors.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              Colors.blueAccent.shade400,
              Colors.blue.shade400,

            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color:  AppColors.white,
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                AppImages.comingsoon,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "Will be available Soon!",
          style: TextStyle(
          fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            'Our team is working hard to bring you an amazing experience. Stay tuned for something exciting!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          ),
          onPressed: () {
            Get.back();
          },

          child: const Text(
            'Back',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
            // Add your button's onPressed logic here
        ),
        ],
      ),
    ),
    ),
    );
  }
}