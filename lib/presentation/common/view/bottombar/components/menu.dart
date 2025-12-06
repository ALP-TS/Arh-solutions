import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:b_soft_appliction/AuthPref.dart';
import 'package:b_soft_appliction/core/res/assets/rive_assets.dart';
import 'package:b_soft_appliction/presentation/common/view/dashboard/dashboard.dart';
import 'package:rive/rive.dart';

import '../../../../../app/config/routes/route_name.dart';
import '../../../../Learn/view/courses/purchased_course_list.dart';
import '../../../../settings/view/settingspageui.dart';
import '../../../../shared/view/comingsoonpage.dart';

class Menu {
  final String title;
  final RiveModel rive;

  Menu({required this.title, required this.rive});
}

class SideBarMenu {
  final String title;
  final IconData icon;
  final void Function() route;

  SideBarMenu({required this.title, required this.icon, required this.route});
}

List<SideBarMenu> sidebarMenus = [
  SideBarMenu(
    title: "Home",
    icon: HugeIcons.strokeRoundedHome10,
    route: () => Get.toNamed(RouteName.navbar),
    // RouteName.navbar,
  ),
  SideBarMenu(
    title: "Profile",
    icon: HugeIcons.strokeRoundedUser,
    route: () => Get.toNamed(RouteName.settings),
  ),
  SideBarMenu(
    title: "Exam",
    icon: HugeIcons.strokeRoundedQuiz03,
    route: () => Get.toNamed(RouteName.listexam),
  ),
  SideBarMenu(
    icon: HugeIcons.strokeRoundedLogout03,
    title: "Log out",
    route: () async {
      await AuthPreferences.logout();
      Get.offAllNamed(RouteName.login);
    },
  ),
];
// List<Menu> sidebarMenus = [
//   Menu(
//     title: "Home",
//     // route
//     rive: RiveModel(
//         src: RiveAssets.icons,
//         artboard: "HOME",
//         stateMachineName: "HOME_interactivity"),
//   ),
//   Menu(
//     title: "Search",
//     rive: RiveModel(
//         src: RiveAssets.icons,
//         artboard: "SEARCH",
//         stateMachineName: "SEARCH_Interactivity"),
//   ),
//   Menu(
//     title: "Favorites",
//     rive: RiveModel(
//         src: RiveAssets.icons,
//         artboard: "LIKE/STAR",
//         stateMachineName: "STAR_Interactivity"),
//   ),
//   Menu(
//     title: "Help",
//     rive: RiveModel(
//         src: RiveAssets.icons,
//         artboard: "CHAT",
//         stateMachineName: "CHAT_Interactivity"),
//   ),
// ];

// List<Menu> sidebarMenus2 = [
//   Menu(
//     title: "History",
//     rive: RiveModel(
//         src: RiveAssets.icons,
//         artboard: "TIMER",
//         stateMachineName: "TIMER_Interactivity"),
//   ),
//   Menu(
//     title: "Notifications",
//     rive: RiveModel(
//         src: RiveAssets.icons,
//         artboard: "BELL",
//         stateMachineName: "BELL_Interactivity"),
//   ),
// ];

List<Menu> bottomNavItems = [
  Menu(
    title: "Home",
    rive: RiveModel(
      src: RiveAssets.icons,
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
    ),
  ),
  //TODO Its may need in future
  Menu(
    title: "My Courses",
    rive: RiveModel(
      src: RiveAssets.icons,
      // artboard: "HOME",
      artboard: "CHAT",
      stateMachineName: "CHAT_Interactivity",
    ),
  ),
  // Menu(
  //   title: "Search",
  //   rive: RiveModel(
  //       src: RiveAssets.icons,
  //       artboard: "SEARCH",
  //       stateMachineName: "SEARCH_Interactivity"),
  // ),
  // Menu(
  //   title: "Timer",
  //   rive: RiveModel(
  //       src: RiveAssets.icons,
  //       artboard: "TIMER",
  //       stateMachineName: "TIMER_Interactivity"),
  // ),

  // Menu(
  //   title: "Notification",
  //   rive: RiveModel(
  //       src: RiveAssets.icons,
  //       artboard: "BELL",
  //       stateMachineName: "BELL_Interactivity"),
  // ),
  Menu(
    title: "Profile",
    rive: RiveModel(
      src: RiveAssets.icons,
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
    ),
  ),
];

class RiveModel {
  final String src, artboard, stateMachineName;
  late SMIBool? status;

  RiveModel({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    this.status,
  });

  set setStatus(SMIBool state) {
    status = state;
  }
}

List pagelist = [
  const Dashboard(isloggedin: true),
  const PurchasedCourseList(),
  const SettingsPage(),
];
