import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:b_soft_appliction/app/Di/dimensions.dart';
import 'package:b_soft_appliction/app/config/theme/colors.dart';
import 'package:b_soft_appliction/app/config/theme/text.dart';
import 'animated_bar.dart';
import 'menu.dart';

class BtmNavItem extends StatelessWidget {
  const BtmNavItem(
      {super.key,
      required this.navBar,
      required this.press,
      required this.riveOnInit,
      required this.selectedNav,
      required this.title});

  final Menu navBar;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final Menu selectedNav;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBar(isActive: selectedNav == navBar),
          SizedBox(
            height: Di.width(0.075),
            width: Di.width(0.075),
            child: Opacity(
              opacity: selectedNav == navBar ? 1 : 0.5,
              child: RiveAnimation.asset(
                navBar.rive.src,
                artboard: navBar.rive.artboard,
                onInit: riveOnInit,
              ),
            ),
          ),
          AppTextHelper.caption(
            text: title,
            fcolor: selectedNav == navBar ? AppColors.white : AppColors.grey,
          ),
        ],
      ),
    );
  }
}
