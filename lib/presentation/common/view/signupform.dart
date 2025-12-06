import 'package:b_soft_appliction/presentation/common/viewmodel/sign_upVm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:b_soft_appliction/app/Di/dimensions.dart';
import 'package:b_soft_appliction/app/config/theme/colors.dart';
import 'package:b_soft_appliction/app/config/theme/text.dart';
import 'package:b_soft_appliction/core/helpers/appbarhelper.dart';
import 'package:b_soft_appliction/presentation/common/viewmodel/formVm.dart';

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    final formVM = Get.put(FormVM());
    final controller = Get.put(SignUpvm());

    return Scaffold(
      appBar: Appbarhelper.dashboardAppbar(
        'Contact Form',
        'Fill in your details',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          formVM.clearForm();
        },
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Di.screenWidth * 0.04,
                    vertical: Di.screenWidth * 0.05,
                  ),
                  child: _FormContent(formVM: formVM),
                );
              }, childCount: 1),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormHeader extends StatelessWidget {
  const _FormHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Di.screenWidth * 0.3,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(Di.screenWidth * 0.05),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F2FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.white),
              ),
              width: double.infinity,
              height: Di.screenWidth * 0.25,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextHelper.subHead(
                          text: 'Get in touch with us',
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        AppTextHelper.caption(text: 'We\'ll respond shortly'),
                      ],
                    ),
                  ),
                  SizedBox(width: Di.screenWidth * 0.15),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 16,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const HugeIcon(
                icon: HugeIcons.strokeRoundedMail01,
                color: AppColors.primary,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormContent extends StatelessWidget {
  final FormVM formVM;

  const _FormContent({required this.formVM});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formVM.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(
            controller: formVM.nameController,
            label: 'Full Name',
            hint: 'Enter your full name',
            icon: HugeIcons.strokeRoundedUser,
            validator: formVM.validateName,
          ),
          const SizedBox(height: 20),
          _buildInputField(
            controller: formVM.emailController,
            label: 'Email Address',
            hint: 'Enter your email',
            icon: HugeIcons.strokeRoundedMail01,
            keyboardType: TextInputType.emailAddress,
            validator: formVM.validateEmail,
          ),
          const SizedBox(height: 20),
          _buildPasswordField(
            controller: formVM.passwordController,
            label: 'Password',
            hint: 'Enter your password',
            icon: HugeIcons.strokeRoundedCirclePassword,
            validator: formVM.validatePassword,
          ),
          const SizedBox(height: 20),
          _buildInputField(
            controller: formVM.phoneController,
            label: 'Phone Number',
            hint: 'Enter your phone number',
            icon: HugeIcons.strokeRoundedCall,
            keyboardType: TextInputType.phone,
            validator: formVM.validatePhone,
            maxLength: 10, // Add this parameter
          ),

          const SizedBox(height: 20),
          _buildClassDropdown(
            label: 'Class',
            hint: 'Select your class',
            icon: HugeIcons.strokeRoundedBook02,
            controller: Get.find<SignUpvm>(),
            formVM: formVM,
          ),
          const SizedBox(height: 32),
          Obx(
            () => _buildSubmitButton(
              isLoading: formVM.isSubmitting.value,
              onPressed: formVM.submitForm,
            ),
          ),
          const SizedBox(height: 24),
          Obx(() {
            if (formVM.successMessage.value.isNotEmpty) {
              return _buildSuccessMessage(formVM.successMessage.value);
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: HugeIcon(icon: icon, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          maxLength: maxLength,
          inputFormatters: maxLength != null
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(maxLength),
                ]
              : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            filled: true,
            fillColor: Colors.grey.shade50,
            counterText: '', // This hides the counter text
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int? maxLength,
  }) {
    final formVM = Get.find<FormVM>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: HugeIcon(icon: icon, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Obx(
          () => TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            obscureText: formVM.obscurePassword.value, // 👈 toggle here
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),

              // 👇 Suffix Icon (Show / Hide)
              suffixIcon: IconButton(
                icon: Icon(
                  formVM.obscurePassword.value
                      ? Icons
                            .visibility_off // hide
                      : Icons.visibility, // show
                  color: AppColors.primary,
                ),
                onPressed: () {
                  formVM.obscurePassword.value =
                      !formVM.obscurePassword.value; // toggle
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClassDropdown({
    required String label,
    required String hint,
    required IconData icon,
    required SignUpvm controller,
    required FormVM formVM,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: HugeIcon(icon: icon, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Obx(() {
          // Show loader while API is fetching
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          // Show message if no data
          if (controller.coursedata.isEmpty) {
            return const Text(
              "No courses available",
              style: TextStyle(color: Colors.red),
            );
          }

          return DropdownButtonFormField<String>(
            value: formVM.selectedClassId.value.isEmpty
                ? null
                : formVM.selectedClassId.value,

            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),

            // -----------------------------------------
            // 🔥 API DATA DROPDOWN ITEMS (Main Update)
            // -----------------------------------------
            items: controller.coursedata.map((course) {
              return DropdownMenuItem<String>(
                value: course.relatedCourseId.toString(),
                child: Text(course.course),
              );
            }).toList(),

            // -----------------------------------------
            // 🔥 Single correct onChanged
            // -----------------------------------------
            onChanged: (value) {
              formVM.selectedClassId.value = value ?? "";
            },

            validator: formVM.validateClass,
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedArrowDown01,
              color: AppColors.primary,
              size: 20,
            ),

            dropdownColor: Colors.white,
            isExpanded: true,
          );
        }),
      ],
    );
  }

  Widget _buildSubmitButton({
    required bool isLoading,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: const Color.fromRGBO(0, 0, 0, 0),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isLoading ? null : onPressed,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedSent,
                        color: Colors.white,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Submit Form',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessMessage(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.green.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade300, width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const HugeIcon(
              icon: HugeIcons.strokeRoundedCheckmarkCircle02,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.green.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
