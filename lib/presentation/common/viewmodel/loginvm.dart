import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b_soft_appliction/core/helpers/dialougehelper.dart';
import 'package:b_soft_appliction/core/utils/debuprint.dart';
import 'package:b_soft_appliction/presentation/settings/viewmodel/profilevm.dart';

import '../../../AuthPref.dart';
import '../../../app/config/routes/route_name.dart';
import '../../../domain/models/adnimprofile_model.dart';
import '../../../domain/models/login_model.dart';
import '../../../domain/repository/loginrepo.dart';

class LoginVM extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadusername();
    consolePrint(
      '==================> Login Controller Initialized',
    );
  }

  final profileVM = Get.find<Profilevm>();

  RxBool obscurePassword = true.obs;

  Future<void> loadusername() async {
    final rememberedUsername = await AuthPreferences.getRememberedUsername();
    emailController.value.text = rememberedUsername ?? '';
  }

  void savelogin(LoginModel usermodel) async {
    await AuthPreferences.setLoggedIn(true);
    await AuthPreferences.setUserId(usermodel.userId.toString());
    await AuthPreferences.setstuId(usermodel.studentId.toString());
    await AuthPreferences.setclassId(usermodel.classId.toString());
    await AuthPreferences.setRememberedUsername(emailController.value.text);
    await profileVM.getProfile();
    if (profileVM.profileData != null) {
      if (profileVM.profileData!.feeStatus == 'expired') {
        await AuthPreferences.logout();
        Dialougehelper.warning(Get.context, 'Subscription Expired',
            'Your subscription has expired. Please renew your subscription to continue using our services.');
      } else {
        Get.offAllNamed(RouteName.navbar);
      }
    } else {
      await AuthPreferences.logout();
      Get.offAllNamed(RouteName.login);
      Dialougehelper.warning(Get.context, 'Profile Issue',
          'Unable to load your profile. Please log out and login again to continue.');
    }
  }

  //*====================> Variables
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  final api = LoginRepo();
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  //*====================> Functions
  Future<void> login() async {
    consolePrint('======================>In login VM (function login) Started');
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      Map data = {
        "username": emailController.value.text,
        "password": passwordController.value.text,
      };
      try {
        final response = await api.loginApi(data);
        final usermodel = LoginModel.fromJson(response['data']);
        final response2 = await api.getloginmode();
        final adminprofile = AdminProfile.fromJson(response2['data']);

        if (Platform.isAndroid) {
          BaseDeviceInfo androidInfo = await DeviceInfoPlugin().deviceInfo;
          String deviceId = androidInfo.data['fingerprint'];
          consolePrint(
              '======================>In login VM (function login) deviceId is $deviceId');
          consolePrint('======================>deviceId is $deviceId ');
          consolePrint(
              '======================>adminprofile.secureMod is ${adminprofile.secureMod}');
          if (adminprofile.secureMod == 'none') {
            savelogin(usermodel);
          } else if (usermodel.deviceId == null || usermodel.deviceId == '') {
            await api.storedeviceId(deviceId, usermodel.userId.toString());
            savelogin(usermodel);
          } else if (usermodel.deviceId == deviceId) {
            savelogin(usermodel);
          } else {
            Dialougehelper.error(
              Get.context!,
              'Error',
              'Please login with previous device',
            );
          }
        } else if (Platform.isIOS) {
          BaseDeviceInfo iosInfo = await DeviceInfoPlugin().deviceInfo;
          String deviceId = iosInfo.data['identifierForVendor'];
          consolePrint(
              '======================>In login VM (function login) deviceId is $deviceId');
          consolePrint('======================>deviceId is $deviceId ');
          consolePrint(
              '======================>adminprofile.secureMod is ${adminprofile.secureMod}');
          if (adminprofile.secureMod == 'none') {
            savelogin(usermodel);
          } else if (usermodel.deviceId == null || usermodel.deviceId == '') {
            await api.storedeviceId(deviceId, usermodel.userId.toString());
            savelogin(usermodel);
          } else if (usermodel.deviceId == deviceId) {
            savelogin(usermodel);
          } else {
            Dialougehelper.error(
              Get.context!,
              'Error',
              'Please login with previous device',
            );
          }
        }
      } catch (e) {
        Dialougehelper.error(
          Get.context!,
          'Error',
          'Invalid username or password',
        );
        consolePrint(
            '======================>In login VM (function login) Error',
            e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      consolePrint(
          '======================>In login VM (function login) Failed');
    }
  }

  //*====================> Validation
  String? emailvalidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? passwordvalidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  void dispose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    consolePrint(
      '==================> Login Controller Closed',
    );
    super.dispose();
  }
}
