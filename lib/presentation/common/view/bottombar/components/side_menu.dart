import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:b_soft_appliction/app/config/theme/colors.dart';
import 'menu.dart';

class SideMenu extends StatelessWidget {
  const SideMenu(
      {super.key,
      required this.menu,
      required this.press,
      // required this.riveOnInit,
      required this.selectedMenu});

  final SideBarMenu menu;
  final VoidCallback press;
  // final ValueChanged<Artboard> riveOnInit;
  final SideBarMenu selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(color: Colors.white24, height: 1),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              width: selectedMenu == menu ? 288 : 0,
              height: 56,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 36,
                width: 36,
                child: HugeIcon(icon: menu.icon, color: Colors.white),
                // RiveAnimation.asset(
                //   menu.rive.src,
                //   artboard: menu.rive.artboard,
                //   onInit: riveOnInit,
                // ),
              ),
              title: Text(
                menu.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
