import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b_soft_appliction/app/config/theme/colors.dart';
import 'package:b_soft_appliction/core/res/assets/images.dart';
import 'package:b_soft_appliction/packages/src/Alp_animated_splashscreen.dart';

import '../../viewmodel/splashvm.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final SplashscreeVM splashscrenVM = Get.find<SplashscreeVM>();
  @override
  void initState() {
    super.initState();
    splashscrenVM.checklogin();
  }

  @override
  Widget build(BuildContext context) {
    // return
    // Scaffold(
    //   backgroundColor: AppColors.primary,
    //   body:Center(child: Image.asset(AppImages.logowhite),)

    // );
    return AnimatedSplashScreen(
      companyname: 'Alp Turnkey Solutions pvt ltd',
      brandnamecolor: AppColors.lightsecondary,
      background: AppColors.black,
      foregroundcolor: AppColors.white,
      logo: AppImages.splashbg,
      brandname: '',
    );
  }
}
