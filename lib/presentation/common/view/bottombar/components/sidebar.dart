import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
// import 'package:get/get.dart';
import 'package:b_soft_appliction/core/res/assets/images.dart';
// import '../../../../profile/viewmodel/profilevm.dart';
import '../../../../../AuthPref.dart';
import '../../../../settings/viewmodel/profilevm.dart';
import 'info_card.dart';
import 'riveutils.dart';
import 'side_menu.dart';
import 'menu.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  SideBarMenu selectedSideMenu = sidebarMenus.first;
  @override
  Widget build(BuildContext context) {
    final profileVM = Get.find<Profilevm>();
    return SafeArea(
      child: Container(
        width: 288,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.sidemenupattern),
            fit: BoxFit.cover,
          ),
          color: Color(0xFF17203A),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Obx(() =>
                //  profileVM.isLoading.value
                // ?
                // const InfoCardShimmer(),
                // :
                InfoCard(
                    name: profileVM.profileData!.name,
                    // profileVM.profile.value!.name,
                    bio: profileVM.profileData!.studentClass,
                    // profileVM.profile.value!.className,
                    image: ''
                    // profileVM.profile.value!.profile,
                    ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text(
                    "Browse".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white70),
                  ),
                ),
                ...sidebarMenus.map(
                  (menu) => SideMenu(
                    menu: menu,
                    selectedMenu: selectedSideMenu,
                    press: () {
                      menu.route();
                      // RiveUtils.chnageSMIBoolState(menu.rive.status!);
                      setState(() {
                        selectedSideMenu = menu;
                      });
                    },
                    // riveOnInit: (artboard) {
                    //   menu.rive.status = RiveUtils.getRiveInput(artboard,
                    //       stateMachineName: menu.rive.stateMachineName);
                    // },
                  ),
                ),
                // SideMenu(
                //   menu: SideBarMenu(
                //       icon: HugeIcons.strokeRoundedLogout03,
                //       title: 'Log Out',
                //       route: ''),
                //   selectedMenu: selectedSideMenu,
                //   press: () async {
                //     await AuthPreferences.logout();
                //     // Get.toNamed(menu.route);
                //     // RiveUtils.chnageSMIBoolState(menu.rive.status!);
                //     setState(() {
                //       selectedSideMenu = SideBarMenu(
                //       icon: HugeIcons.strokeRoundedLogout03,
                //       title: 'Log Out',
                //       route: '');
                //     });
                //   },
                //   // riveOnInit: (artboard) {
                //   //   menu.rive.status = RiveUtils.getRiveInput(artboard,
                //   //       stateMachineName: menu.rive.stateMachineName);
                //   // },
                // )
                // Padding(
                //   padding: const EdgeInsets.only(left: 24, top: 40, bottom: 16),
                //   child: Text(
                //     "History".toUpperCase(),
                //     style: Theme.of(context)
                //         .textTheme
                //         .titleMedium!
                //         .copyWith(color: Colors.white70),
                //   ),
                // ),
                // ...sidebarMenus2.map((menu) => SideMenu(
                //       menu: menu,
                //       selectedMenu: selectedSideMenu,
                //       press: () {
                //         RiveUtils.chnageSMIBoolState(menu.rive.status!);
                //         setState(() {
                //           selectedSideMenu = menu;
                //         });
                //       },
                //       riveOnInit: (artboard) {
                //         menu.rive.status = RiveUtils.getRiveInput(artboard,
                //             stateMachineName: menu.rive.stateMachineName);
                //       },
                //     )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
