import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/Di/dimensions.dart';
import '../../../../../app/config/theme/text.dart';
import '../../../../../core/helpers/buttonhelper.dart';
import '../../../../../core/utils/debuprint.dart';

class Promocontent extends StatelessWidget {
  const Promocontent({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Di.width(0.04),vertical: Di.width(0.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        
        children: [
          AppTextHelper.mainHead(
            text: 'wel_scre_title'.tr,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            fcolor: Colors.black,
            
          ),
          const SizedBox(height: 10),
          AppTextHelper.caption(
            text: 'wel_sce_des'.tr,
            textAlign: TextAlign.center,
            fcolor: Colors.grey,
          ),
          const SizedBox(height: 20),
          Buttonhelper.normalButton(
            text: 'get_started'.tr,
            onPressed: () {
              consolePrint('Navigating to Login Screen');
              onPressed!();
            },
            isLoading: false,
          ),
        ],
      ),
    );
  }
}
