import 'package:arh_solution_app/app/config/routes/route_name.dart';
import 'package:arh_solution_app/presentation/common/view/signupform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arh_solution_app/app/config/theme/colors.dart';
import 'package:arh_solution_app/core/helpers/buttonhelper.dart';
import 'package:arh_solution_app/core/res/assets/images.dart';
import 'package:arh_solution_app/presentation/common/viewmodel/loginvm.dart';

import '../../../../../app/config/theme/text.dart';

class Loginform extends StatelessWidget {
  Loginform({super.key, required this.loginVM});

  final LoginVM loginVM;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: loginVM.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(AppImages.logoimg, height: 100),
            const SizedBox(height: 24.0),
            AppTextHelper.mainHead(
              text: 'welcome'.tr,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            AppTextHelper.subHead(
              text: 'login'.tr,
              textAlign: TextAlign.center,
              fcolor: AppColors.grey,
            ),
            const SizedBox(height: 32.0),
            TextFormField(
              controller: loginVM.emailController.value,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                labelText: 'email'.tr,
                hintText: 'email_hint'.tr,
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: loginVM.emailvalidation,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: loginVM.passwordController.value,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                labelText: 'password'.tr,
                hintText: 'password_hint'.tr,
                prefixIcon: const Icon(Icons.lock_open_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    loginVM.obscurePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    loginVM.obscurePassword.value =
                        !loginVM.obscurePassword.value;
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              obscureText: loginVM.obscurePassword.value,
              validator: loginVM.passwordvalidation,
            ),
            // const SizedBox(height: 8.0),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: TextButton(
            //     onPressed: () {
            //       // // TODO: Implement forgot password functionality
            //       // print('Forgot password pressed');
            //     },
            //     child: Text(
            //       'forgot_password'.tr,
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 24.0),
            Buttonhelper.normalButton(
              text: 'login_button'.tr,
              onPressed: loginVM.login,
              isLoading: loginVM.isLoading.value,
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("no_account".tr),
                TextButton(
                  onPressed: () {
                    Get.to(() => FormView());

                    print('Sign up pressed');
                  },
                  child: Text(
                    'signup'.tr,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
