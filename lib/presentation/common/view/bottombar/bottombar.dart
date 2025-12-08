import 'package:get/get.dart';
import 'package:arh_solution_app/app/config/theme/colors.dart';
import 'package:arh_solution_app/core/helpers/dialougehelper.dart';
import '../../../../app/Di/dimensions.dart';
import 'package:flutter/material.dart';
import '../../../settings/viewmodel/profilevm.dart';
import 'components/menubutton.dart';
import 'components/nav_button.dart';
import 'components/riveutils.dart';
import 'components/sidebar.dart';
import 'package:rive/rive.dart';
import 'components/menu.dart';
import 'dart:math';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  bool isSideBarOpen = false;
  int pageindex = 0;

  Menu selectedBottonNav = bottomNavItems.first;
  SideBarMenu selectedSideMenu = sidebarMenus.first;

  late SMIBool isMenuOpenInput;

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 200),
        )..addListener(() {
          setState(() {});
        });
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await Dialougehelper.confirmation(
          context,
          "Exit",
          "Are you sure you want to exit?",
        );
        //  await showExitConfirmationDialog(context);
        return shouldExit;
      },
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.lightprimary,
        body: Stack(
          children: [
            AnimatedPositioned(
              width: 288,
              height: MediaQuery.of(context).size.height,
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: isSideBarOpen ? 0 : -288,
              top: 0,
              child: const SideBar(),
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(
                  1 * animation.value - 30 * (animation.value) * pi / 180,
                ),
              child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                child: Transform.scale(
                  scale: scalAnimation.value,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: pagelist[pageindex],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: isSideBarOpen ? 220 : Di.screenWidth - 70,
              top: 10,
              child: MenuBtn(
                press: () {
                  isMenuOpenInput.value = !isMenuOpenInput.value;

                  if (_animationController.value == 0) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }

                  setState(() {
                    isSideBarOpen = !isSideBarOpen;
                  });
                },
                riveOnInit: (artboard) {
                  final controller = StateMachineController.fromArtboard(
                    artboard,
                    "State Machine",
                  );

                  artboard.addController(controller!);

                  isMenuOpenInput =
                      controller.findInput<bool>("isOpen") as SMIBool;
                  isMenuOpenInput.value = true;
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Transform.translate(
          offset: Offset(0, 100 * animation.value),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Di.width(0.07),
              vertical: Di.width(0.02),
            ),
            // const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
            // margin: EdgeInsets.symmetric(
            //     horizontal: Di.width(0.04), vertical: Di.width(0.02)),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),

              // border: Border(
              //   top: BorderSide(color: AppColors.primary, width: 2),
              // ),
              // borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 20),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(bottomNavItems.length, (index) {
                  Menu navBar = bottomNavItems[index];

                  return BtmNavItem(
                    title: navBar.title,
                    navBar: navBar,
                    press: () {
                      // Utils.snackBar('$index','$pageindex');
                      setState(() {
                        pageindex = index;
                      });
                      RiveUtils.chnageSMIBoolState(navBar.rive.status!);
                      updateSelectedBtmNav(navBar);
                    },
                    riveOnInit: (artboard) {
                      navBar.rive.status = RiveUtils.getRiveInput(
                        artboard,
                        stateMachineName: navBar.rive.stateMachineName,
                      );
                    },
                    selectedNav: selectedBottonNav,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
