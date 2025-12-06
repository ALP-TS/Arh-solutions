import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:b_soft_appliction/app/config/routes/route_name.dart';
import 'package:b_soft_appliction/core/helpers/dialougehelper.dart';
import 'package:b_soft_appliction/presentation/common/view/dashboard/dashboard.dart';

import '../../../AuthPref.dart';
import '../../settings/viewmodel/profilevm.dart';

class SplashscreeVM extends GetxController {
  final profileVM = Get.find<Profilevm>();
  bool isloggedin = false;
  Future<void> checklogin() async {
    isloggedin = await AuthPreferences.isLoggedIn();

    if (isloggedin) {
      await profileVM.getProfile();
      final profileData = profileVM.profileData;
      if (profileData != null) {
        if (profileData.status == '0') {
          await AuthPreferences.logout();
          Get.offAllNamed(RouteName.signup);
          // Navigator.push(
          //   Get.context!,
          //   MaterialPageRoute(
          //     builder: (context) => const Dashboard(isloggedin: false),
          //   ),
          // );
          Dialougehelper.warning(
            Get.context,
            'Blocked Account',
            'Your account has been blocked. Please contact support for further assistance.',
          );
        } else if (profileData.feeStatus != 'active') {
          Get.offAllNamed(RouteName.signup);
          // Navigator.push(
          //   Get.context!,
          //   MaterialPageRoute(
          //     builder: (context) => const Dashboard(isloggedin: false),
          //   ),
          // );
          Dialougehelper.warning(
            Get.context,
            'Subscription Expired',
            'Your subscription has expired. Please renew your subscription to continue using our services.',
          );
        } else {
          Timer(
            const Duration(seconds: 4),
            () => Get.offAllNamed(RouteName.navbar),
          );
        }
      } else {
        await AuthPreferences.logout();
        Get.offAllNamed(RouteName.signup);
        // Navigator.push(
        //   Get.context!,
        //   MaterialPageRoute(
        //     builder: (context) => const Dashboard(isloggedin: false),
        //   ),
        // );
        Dialougehelper.warning(
          Get.context,
          'Profile Issue',
          'Unable to load your profile. Please log out and login again to continue.',
        );
      }
    } else {
      Timer(
        const Duration(seconds: 4),
        () => Get.offAllNamed(RouteName.onboard),
      );
    }
  }
}
