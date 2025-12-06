
import 'package:flutter/material.dart';

import '../../../../../core/res/assets/images.dart';

class PromoImage extends StatelessWidget {
  const PromoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // flex: ,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     Colors.white,
          //     Colors.blue,
          //   ],
          // ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Image.asset(AppImages.welcomeimg)),
        ),
      ),
    );
  }
}
