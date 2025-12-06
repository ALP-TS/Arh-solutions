import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b_soft_appliction/core/res/assets/images.dart';
import 'package:b_soft_appliction/presentation/common/view/login/src/loginform.dart';
import '../../viewmodel/loginvm.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginVM = Get.find<LoginVM>();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.loginbg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Container(color: Colors.black.withOpacity(0.5)),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Loginform(loginVM: loginVM),
            ),
          ),
        ],
      ),
    );
  }
}
