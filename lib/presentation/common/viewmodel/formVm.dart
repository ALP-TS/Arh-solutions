import 'package:b_soft_appliction/app/config/routes/route_name.dart';
import 'package:b_soft_appliction/domain/models/signupResponse.dart';
import 'package:b_soft_appliction/presentation/common/view/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b_soft_appliction/presentation/common/viewmodel/sign_upVm.dart';
import 'package:b_soft_appliction/core/utils/debuprint.dart';

class FormVM extends GetxController {
  final formKey = GlobalKey<FormState>();
  // final formVM = Get.find<FormVM>();

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  // Observable variables
  var isSubmitting = false.obs;
  var successMessage = ''.obs;
  var obscurePassword = true.obs;
  var selectedClassId = ''.obs;

  // Validator functions
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }

    final regex = RegExp(r'^[a-zA-Z.\s]+$');

    if (!regex.hasMatch(value.trim())) {
      return 'Name can contain only alphabets and spaces';
    }

    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.trim().length != 10) {
      return 'Phone number must be 10 digits';
    }
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateClass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a class';
    }
    return null;
  }

  // Show success dialog
  void _showSuccessDialog(String message) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green.shade600,
                  size: 64,
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Registration Successful!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Text(
                'Please wait, we will contact you soon...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Your account is currently under review. You will be able to access the app once the administrator approves your account.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.redAccent,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // OK Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        clearForm();
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Get.offAllNamed(RouteName.login);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> submitForm() async {
    successMessage.value = '';

    // Validate form
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'Validation Error',
        'Please fill all fields correctly',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
      return;
    }

    // Check if class is selected
    if (selectedClassId.value.isEmpty) {
      Get.snackbar(
        'Selection Required',
        'Please select a class',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade100,
        colorText: Colors.orange.shade900,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
      return;
    }

    try {
      isSubmitting.value = true;
      consolePrint('===================> Form Submission Started');

      final signUpVm = Get.find<SignUpvm>();
      successMessage.value = '';

      // Call the signup API
      final response = await signUpVm.api.getSignupResponse(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        class_id: selectedClassId.value.toString(),
        password: passwordController.text,
        phone: phoneController.text.trim(),
      );

      consolePrint('classId: ${selectedClassId.value.toString()}');
      consolePrint('===================> Signup Response: $response');

      // Check if response is successful
      if (response?['status']?.toString().toLowerCase() == "success") {
        successMessage.value =
            response['message'] ?? 'Registration successful!';

        // Show success dialog instead of snackbar
        _showSuccessDialog(successMessage.value);
      } else {
        final errorMessage =
            response?['message'] ?? 'Registration failed. Please try again.';

        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      consolePrint(
        '===================> Form Submission Error: ${e.toString()}',
      );

      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    } finally {
      isSubmitting.value = false;
      consolePrint('===================> Form Submission Completed');
    }
  }

  // Clear form function
  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    selectedClassId.value = '';
    successMessage.value = '';
    formKey.currentState?.reset();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
