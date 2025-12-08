import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arh_solution_app/core/res/assets/images.dart';
import 'package:arh_solution_app/core/utils/debuprint.dart';
import 'package:arh_solution_app/presentation/common/view/dashboard/dashboard.dart';
import '../../../../app/config/routes/route_name.dart';
import 'src/promocontent.dart';
import 'src/promoimg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  void navigateToLogin() {
    consolePrint('Navigating to Login Screen');
    Get.offAllNamed(RouteName.signup);
    // Navigator.push(
    //   Get.context!,
    //   MaterialPageRoute(
    //     builder: (context) => const Dashboard(isloggedin: false),
    //   ),
    // );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.welcomeimg),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          children: [
            // const PromoImage(),
            Expanded(child: Promocontent(onPressed: () => navigateToLogin())),
          ],
        ),
      ),
    );
  }
}
