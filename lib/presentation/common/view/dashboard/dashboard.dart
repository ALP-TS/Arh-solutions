// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_card_swiper/flutter_card_swiper.dart';
// import 'package:get/get.dart';
// import 'package:hugeicons/hugeicons.dart';
// import 'package:intl/intl.dart';
// import 'package:arh_solution_app/AuthPref.dart';
// import 'package:arh_solution_app/core/helpers/appbarhelper.dart';
// import 'package:arh_solution_app/app/config/theme/text.dart';
// import 'package:arh_solution_app/core/res/assets/images.dart';
// import 'package:arh_solution_app/core/utils/debuprint.dart';
// import 'package:arh_solution_app/domain/models/zoommeetlist_model.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../../app/Di/dimensions.dart';
// import '../../../../app/config/theme/colors.dart';
// import '../../../settings/viewmodel/profilevm.dart';
// import '../../viewmodel/categoryvm.dart';
// import '../../viewmodel/zoomvm.dart';
// import 'src/categorygrid.dart';
// import 'src/coursegrid.dart';

// class Dashboard extends StatelessWidget {
//   const Dashboard({super.key, required this.isloggedin});
//   final bool isloggedin;

//   @override
//   Widget build(BuildContext context) {
//     final categoryVM = Get.find<CategoryVM>();
//     final zoomVM = Get.find<ZoomVM>();
//     final profileVM = Get.find<Profilevm>();

//     return Scaffold(
//       appBar: Appbarhelper.dashboardAppbar(
//         isloggedin: isloggedin,
//         isloggedin ? profileVM.profileData!.name : '',
//         isloggedin ? profileVM.profileData!.email : '',
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           zoomVM.getZoomlist();
//           categoryVM.getCategorylist();
//           categoryVM.getCourselist();
//           profileVM.getProfile();
//         },
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               leading: const SizedBox(),
//               backgroundColor: AppColors.grey.withOpacity(0.5),
//               collapsedHeight: Di.screenWidth * 0.2,
//               expandedHeight: Di.screenWidth * 0.55,
//               floating: true,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Container(
//                   padding: const EdgeInsets.all(16.0),
//                   child: const WelcomeContent(),
//                 ),
//               ),
//               shape: const ContinuousRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(40),
//                   bottomRight: Radius.circular(40),
//                 ),
//               ),
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate((context, index) {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: Di.screenWidth * 0.02,
//                   ),
//                   child: const Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       HorizontalZoomMeetings(),

//                       SizedBox(height: 12),
//                       CategoryGrid(),
//                       SizedBox(height: 24),
//                       // Text(
//                       //   'Course List',
//                       //   style: TextStyle(
//                       //     fontSize: 18,
//                       //     fontWeight: FontWeight.bold,
//                       //     color: Colors.red

//                       //   ),
//                       // ),
//                       CourseGrid(),
//                       // WhatsAppShareButton(
//                       //   imageAssetPath: 'assets/images/comingsoon.jpeg',
//                       //   textContent: 'Hello', url: 'https://example.com',),
//                       SizedBox(height: 70),
//                     ],
//                   ),
//                 );
//               }, childCount: 1),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip(IconData icon, String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 16, color: const Color.fromARGB(255, 227, 20, 20)),
//           const SizedBox(width: 4),
//           Text(text, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
//         ],
//       ),
//     );
//   }
// }

// // ignore: camel_case_types
// class WelcomeContent extends StatelessWidget {
//   const WelcomeContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         // color: AppColors.black.withOpacity(0.3),
//         height: Di.screenWidth * 0.45,
//         child: Image.asset(
//           AppImages.splashbg,
//         )

//         // Stack(
//         //   children: [
//         //     Align(
//         //       alignment: Alignment.bottomCenter,
//         //       child: Container(
//         //         padding: EdgeInsets.all(Di.screenWidth * 0.05),
//         //         decoration: BoxDecoration(
//         //           color: const Color(0xFFE6F2FF),
//         //           borderRadius: BorderRadius.circular(12),
//         //           border: Border.all(color: AppColors.white),
//         //         ),
//         //         width: double.infinity,
//         //         height: Di.screenWidth * 0.4,
//         //         child: Row(
//         //           crossAxisAlignment: CrossAxisAlignment.start,
//         //           children: [
//         //             // Left section with text
//         //             Expanded(
//         //               child:

//         //               Column(
//         //                 crossAxisAlignment: CrossAxisAlignment.start,
//         //                 children: [
//         //                   AppTextHelper.subHead(
//         //                     text:
//         //                         'Our Learning Management System is designed to simplify education delivery',
//         //                     fontWeight: FontWeight.bold,
//         //                   ),
//         //                   const Spacer(),
//         //                   AppTextHelper.caption(text: 'Empowering Education'),
//         //                 ],
//         //               ),
//         //             ),

//         //             // Right spacing (instead of Expanded use SizedBox)
//         //             SizedBox(width: Di.screenWidth * 0.15),
//         //           ],
//         //         ),
//         //       ),
//         //     ),

//         //     // Rotated image
//         //     Positioned(
//         //       right: 0,
//         //       bottom: 0,
//         //       child: Transform.rotate(
//         //         angle: 0.30, // radians
//         //         child: Image.asset(
//         //           AppImages.nursedash,
//         //           height: Di.screenWidth * 0.6,
//         //         ),
//         //       ),
//         //     ),
//         //   ],
//         // ),

//         );
//   }
// }

// class HorizontalZoomMeetings extends StatefulWidget {
//   const HorizontalZoomMeetings({super.key});

//   @override
//   State<HorizontalZoomMeetings> createState() => _HorizontalZoomMeetingsState();
// }

// class _HorizontalZoomMeetingsState extends State<HorizontalZoomMeetings> {
//   @override
//   Widget build(BuildContext context) {
//     final profileVM = Get.find<Profilevm>();
//     final ZoomMeetingVM = Get.find<ZoomVM>();

//     return Obx(() {
//       if (ZoomMeetingVM.isloading.value) {
//         return _buildShimmerEffect();
//       } else if (ZoomMeetingVM.meetlist.isEmpty) {
//         return const SizedBox.shrink();
//       }
//       return _buildMeetingList(
//         ZoomMeetingVM,
//         stuname: profileVM.profileData!.name,
//       );
//     });
//   }

//   Widget _buildMeetingList(ZoomVM vm, {required String stuname}) {
//     return Obx(
//       () => Container(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Colors.blue.shade400, Colors.blue.shade600],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.blue.withOpacity(0.3),
//                           blurRadius: 8,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: const Icon(
//                       Icons.video_library,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Upcoming Live Sessions',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: -0.5,
//                         ),
//                       ),
//                       Text(
//                         'Swipe to explore sessions',
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               height: 280,
//               child: Column(
//                 children: [
//                   Visibility(
//                     visible:
//                         vm.swipcard < vm.meetlist.length || vm.meetlist.isEmpty,
//                     child: Expanded(
//                       child: CardSwiper(
//                         onSwipe: (
//                           int previousIndex,
//                           int? currentIndex,
//                           CardSwiperDirection direction,
//                         ) {
//                           vm.swipcard++;
//                           consolePrint('swipedCardsCount ${vm.swipcard}');
//                           return true;
//                         },
//                         numberOfCardsDisplayed:
//                             vm.meetlist.length < 2 ? vm.meetlist.length : 2,
//                         isLoop: false,
//                         cardsCount: vm.meetlist.length,
//                         cardBuilder: (
//                           context,
//                           index,
//                           percentThresholdX,
//                           percentThresholdY,
//                         ) {
//                           final meeting = vm.meetlist[index];
//                           final meetingDuration = int.parse(
//                             meeting.duration,
//                           );
//                           final difference = meeting.scheduleDateTime
//                               .difference(DateTime.now());
//                           final isNextMeeting = (difference.inMinutes <= 5 &&
//                                   difference.inMinutes >= 0) ||
//                               (difference.inMinutes < 0 &&
//                                   difference.inMinutes >= -meetingDuration);
//                           final date = DateFormat(
//                             'EEE, MMM dd',
//                           ).format(meeting.scheduleDateTime);
//                           final starttime = DateFormat(
//                             'h:mm a',
//                           ).format(meeting.scheduleDateTime);
//                           final endtime = DateFormat('h:mm a').format(
//                             meeting.scheduleDateTime.add(
//                               Duration(
//                                 minutes: int.parse(meeting.duration),
//                               ),
//                             ),
//                           );

//                           return _buildModernMeetingCard(
//                             isNextMeeting: isNextMeeting,
//                             date: date,
//                             meeting: meeting,
//                             stuname: stuname,
//                             context: context,
//                             starttime: starttime,
//                             endtime: endtime,
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   if (vm.swipcard >= vm.meetlist.length &&
//                       vm.meetlist.isNotEmpty)
//                     Expanded(
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 16),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.blue.shade50,
//                               Colors.purple.shade50,
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: Colors.blue.shade100,
//                             width: 2,
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.blue.withOpacity(0.2),
//                                     blurRadius: 16,
//                                     spreadRadius: 4,
//                                   ),
//                                 ],
//                               ),
//                               child: const HugeIcon(
//                                 icon: HugeIcons.strokeRoundedCreditCardNotFound,
//                                 color: AppColors.primary,
//                                 size: 40,
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             const Text(
//                               'All caught up!',
//                               style: TextStyle(
//                                 color: AppColors.primary,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               'Pull to refresh for more sessions',
//                               style: TextStyle(
//                                 color: Colors.grey.shade600,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildModernMeetingCard({
//     required bool isNextMeeting,
//     required String date,
//     required ZoomMeeting meeting,
//     required String stuname,
//     required BuildContext context,
//     required String starttime,
//     required String endtime,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: isNextMeeting
//               ? [Colors.green.shade400, Colors.green.shade600]
//               : [Colors.white, Colors.grey.shade50],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: isNextMeeting
//                 ? Colors.green.withOpacity(0.3)
//                 : Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(24),
//         child: Stack(
//           children: [
//             // Decorative circles
//             Positioned(
//               right: -30,
//               top: -30,
//               child: Container(
//                 width: 120,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   color: isNextMeeting
//                       ? Colors.white.withOpacity(0.1)
//                       : Colors.blue.withOpacity(0.05),
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//             Positioned(
//               left: -20,
//               bottom: -20,
//               child: Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: isNextMeeting
//                       ? Colors.white.withOpacity(0.1)
//                       : Colors.purple.withOpacity(0.05),
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//             // Content
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header with status badge
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isNextMeeting
//                               ? Colors.white
//                               : Colors.green.shade50,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Container(
//                               width: 8,
//                               height: 8,
//                               decoration: BoxDecoration(
//                                 color: isNextMeeting
//                                     ? Colors.green
//                                     : Colors.orange,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                             const SizedBox(width: 6),
//                             Text(
//                               isNextMeeting ? 'Live Now' : 'Scheduled',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: isNextMeeting
//                                     ? Colors.green.shade700
//                                     : Colors.orange.shade700,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Spacer(),
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: isNextMeeting
//                               ? Colors.white.withOpacity(0.2)
//                               : Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(
//                           Icons.calendar_today,
//                           size: 16,
//                           color: isNextMeeting
//                               ? Colors.white
//                               : Colors.grey.shade700,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   // Meeting title
//                   Text(
//                     meeting.topic,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color:
//                           isNextMeeting ? Colors.white : Colors.grey.shade900,
//                       height: 1.2,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 12),
//                   // Date and time info
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: isNextMeeting
//                           ? Colors.white.withOpacity(0.15)
//                           : Colors.blue.shade50,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.access_time,
//                           size: 16,
//                           color: isNextMeeting
//                               ? Colors.white
//                               : Colors.blue.shade700,
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             '$date • $starttime - $endtime',
//                             style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               color: isNextMeeting
//                                   ? Colors.white
//                                   : Colors.blue.shade700,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   // Host info
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: isNextMeeting
//                               ? Colors.white.withOpacity(0.15)
//                               : Colors.purple.shade50,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           Icons.person,
//                           size: 16,
//                           color: isNextMeeting
//                               ? Colors.white
//                               : Colors.purple.shade700,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Host',
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: isNextMeeting
//                                     ? Colors.white70
//                                     : Colors.grey.shade600,
//                               ),
//                             ),
//                             Text(
//                               meeting.staffName,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: isNextMeeting
//                                     ? Colors.white
//                                     : Colors.grey.shade900,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isNextMeeting
//                               ? Colors.white.withOpacity(0.15)
//                               : Colors.orange.shade50,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               Icons.schedule,
//                               size: 14,
//                               color: isNextMeeting
//                                   ? Colors.white
//                                   : Colors.orange.shade700,
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               '${meeting.duration} min',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: isNextMeeting
//                                     ? Colors.white
//                                     : Colors.orange.shade700,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   // Action button
//                   Container(
//                     width: double.infinity,
//                     height: 52,
//                     decoration: BoxDecoration(
//                       gradient: isNextMeeting
//                           ? const LinearGradient(
//                               colors: [Colors.white, Colors.white],
//                             )
//                           : LinearGradient(
//                               colors: [
//                                 Colors.blue.shade400,
//                                 Colors.blue.shade600,
//                               ],
//                             ),
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: (isNextMeeting ? Colors.white : Colors.blue)
//                               .withOpacity(0.3),
//                           blurRadius: 12,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(16),
//                         onTap: () {
//                           // Your join logic here
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               isNextMeeting
//                                   ? Icons.videocam
//                                   : Icons.info_outline,
//                               color: isNextMeeting
//                                   ? Colors.green.shade700
//                                   : Colors.white,
//                               size: 22,
//                             ),
//                             const SizedBox(width: 10),
//                             Text(
//                               isNextMeeting ? 'Join Session' : 'View Details',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: isNextMeeting
//                                     ? Colors.green.shade700
//                                     : Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildShimmerEffect() {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Shimmer.fromColors(
//               baseColor: Colors.grey[300]!,
//               highlightColor: Colors.grey[100]!,
//               child: Row(
//                 children: [
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: 180,
//                         height: 20,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Container(
//                         width: 120,
//                         height: 14,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           SizedBox(
//             height: 280,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: 2,
//               itemBuilder: (context, index) {
//                 return Container(
//                   width: MediaQuery.of(context).size.width - 32,
//                   margin: EdgeInsets.only(right: index == 0 ? 12 : 0),
//                   child: Shimmer.fromColors(
//                     baseColor: Colors.grey[300]!,
//                     highlightColor: Colors.grey[100]!,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:ui';

import 'package:arh_solution_app/core/res/assets/images.dart';
import 'package:arh_solution_app/core/utils/debuprint.dart';
import 'package:arh_solution_app/domain/models/zoommeetlist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

import 'package:shimmer/shimmer.dart';
import '../../../../app/Di/dimensions.dart';
import '../../../../app/config/routes/route_name.dart';
import '../../../../app/config/theme/colors.dart';
import '../../../../app/config/theme/text.dart';
import '../../../../core/helpers/appbarhelper.dart';
import '../../../settings/viewmodel/profilevm.dart';
import '../../viewmodel/categoryvm.dart';
import '../../viewmodel/zoomvm.dart';
import 'src/categorygrid.dart';
import 'src/coursegrid.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, required this.isloggedin});
  final bool isloggedin;

  @override
  Widget build(BuildContext context) {
    final categoryVM = Get.find<CategoryVM>();
    final zoomVM = Get.find<ZoomVM>();
    final profileVM = Get.find<Profilevm>();

    return Scaffold(
      appBar: Appbarhelper.dashboardAppbar(
        isloggedin: isloggedin,
        isloggedin ? profileVM.profileData!.name : '',
        isloggedin ? profileVM.profileData!.email : '',
      ),
      bottomNavigationBar: isloggedin
          ? null
          : GestureDetector(
              onTap: () => Get.toNamed(RouteName.login),
              child: Container(
                decoration: const BoxDecoration(color: AppColors.primary),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppTextHelper.button(
                        text: 'Click here to Login',
                        fcolor: AppColors.white,
                      ),
                      Icon(Icons.login, color: AppColors.white),
                    ],
                  ),
                ),
              ),
            ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            zoomVM.getZoomlist();
            categoryVM.getCategorylist();
            categoryVM.getCourselist();
            profileVM.getProfile();
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: const SizedBox(),
                backgroundColor: AppColors.black.withOpacity(0.5),
                collapsedHeight: Di.screenWidth * 0.2,
                expandedHeight: Di.screenWidth * 0.55,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const WelcomeContent(),
                  ),
                ),
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Di.screenWidth * 0.02,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HorizontalZoomMeetings(),

                        SizedBox(height: 12),
                        CategoryGrid(),
                        SizedBox(height: 24),
                        // Text(
                        //   'Course List',
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.red

                        //   ),
                        // ),
                        CourseGrid(),

                        // WhatsAppShareButton(
                        //   imageAssetPath: 'assets/images/comingsoon.jpeg',
                        //   textContent: 'Hello', url: 'https://example.com',),
                        SizedBox(height: 70),
                      ],
                    ),
                  );
                }, childCount: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.black.withOpacity(0.3),
      height: Di.screenWidth * 0.45,
      child: Image.asset(AppImages.splashbg),

      // Stack(
      //   children: [
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: Container(
      //         padding: EdgeInsets.all(Di.screenWidth * 0.05),
      //         decoration: BoxDecoration(
      //           color: const Color(0xFFE6F2FF),
      //           borderRadius: BorderRadius.circular(12),
      //           border: Border.all(color: AppColors.white),
      //         ),
      //         width: double.infinity,
      //         height: Di.screenWidth * 0.4,
      //         child: Row(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             // Left section with text
      //             Expanded(
      //               child:

      //               Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   AppTextHelper.subHead(
      //                     text:
      //                         'Our Learning Management System is designed to simplify education delivery',
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                   const Spacer(),
      //                   AppTextHelper.caption(text: 'Empowering Education'),
      //                 ],
      //               ),
      //             ),

      //             // Right spacing (instead of Expanded use SizedBox)
      //             SizedBox(width: Di.screenWidth * 0.15),
      //           ],
      //         ),
      //       ),
      //     ),

      //     // Rotated image
      //     Positioned(
      //       right: 0,
      //       bottom: 0,
      //       child: Transform.rotate(
      //         angle: 0.30, // radians
      //         child: Image.asset(
      //           AppImages.nursedash,
      //           height: Di.screenWidth * 0.6,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class HorizontalZoomMeetings extends StatefulWidget {
  const HorizontalZoomMeetings({super.key});

  @override
  State<HorizontalZoomMeetings> createState() => _HorizontalZoomMeetingsState();
}

class _HorizontalZoomMeetingsState extends State<HorizontalZoomMeetings> {
  @override
  Widget build(BuildContext context) {
    final profileVM = Get.find<Profilevm>();
    final ZoomMeetingVM = Get.find<ZoomVM>();

    return Obx(() {
      if (ZoomMeetingVM.isloading.value) {
        return _buildShimmerEffect();
      } else if (ZoomMeetingVM.meetlist.isEmpty) {
        return const SizedBox.shrink();
      }
      return _buildMeetingList(
        ZoomMeetingVM,
        stuname: profileVM.profileData!.name,
      );
    });
  }

  Widget _buildMeetingList(ZoomVM vm, {required String stuname}) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade600],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.video_library,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upcoming Live Sessions',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        'Swipe to explore sessions',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 360,
              child: Column(
                children: [
                  Visibility(
                    visible:
                        vm.swipcard < vm.meetlist.length || vm.meetlist.isEmpty,
                    child: Expanded(
                      child: CardSwiper(
                        onSwipe:
                            (
                              int previousIndex,
                              int? currentIndex,
                              CardSwiperDirection direction,
                            ) {
                              vm.swipcard++;
                              consolePrint('swipedCardsCount ${vm.swipcard}');
                              return true;
                            },
                        numberOfCardsDisplayed: vm.meetlist.length < 2
                            ? vm.meetlist.length
                            : 2,
                        isLoop: false,
                        cardsCount: vm.meetlist.length,
                        cardBuilder:
                            (
                              context,
                              index,
                              percentThresholdX,
                              percentThresholdY,
                            ) {
                              final meeting = vm.meetlist[index];
                              final meetingDuration = int.parse(
                                meeting.duration,
                              );
                              final difference = meeting.scheduleDateTime
                                  .difference(DateTime.now());
                              final isNextMeeting =
                                  (difference.inMinutes <= 5 &&
                                      difference.inMinutes >= 0) ||
                                  (difference.inMinutes < 0 &&
                                      difference.inMinutes >= -meetingDuration);
                              final date = DateFormat(
                                'EEE, MMM dd',
                              ).format(meeting.scheduleDateTime);
                              final starttime = DateFormat(
                                'h:mm a',
                              ).format(meeting.scheduleDateTime);
                              final endtime = DateFormat('h:mm a').format(
                                meeting.scheduleDateTime.add(
                                  Duration(
                                    minutes: int.parse(meeting.duration),
                                  ),
                                ),
                              );

                              return _buildModernMeetingCard(
                                isNextMeeting: isNextMeeting,
                                date: date,
                                meeting: meeting,
                                stuname: stuname,
                                context: context,
                                starttime: starttime,
                                endtime: endtime,
                              );
                            },
                      ),
                    ),
                  ),
                  if (vm.swipcard >= vm.meetlist.length &&
                      vm.meetlist.isNotEmpty)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade50,
                              Colors.purple.shade50,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.blue.shade100,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.2),
                                    blurRadius: 16,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: const HugeIcon(
                                icon: HugeIcons.strokeRoundedCreditCardNotFound,
                                color: AppColors.primary,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'All caught up!',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Pull to refresh for more sessions',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernMeetingCard({
    required bool isNextMeeting,
    required String date,
    required ZoomMeeting meeting,
    required String stuname,
    required BuildContext context,
    required String starttime,
    required String endtime,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isNextMeeting
              ? [Colors.green.shade400, Colors.green.shade600]
              : [Colors.white, Colors.grey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isNextMeeting
                ? Colors.green.withOpacity(0.3)
                : Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: isNextMeeting
                      ? Colors.white.withOpacity(0.1)
                      : Colors.blue.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: -20,
              bottom: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: isNextMeeting
                      ? Colors.white.withOpacity(0.1)
                      : Colors.purple.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with status badge
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isNextMeeting
                              ? Colors.white
                              : Colors.green.shade50,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isNextMeeting
                                    ? Colors.green
                                    : Colors.orange,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isNextMeeting ? 'Live Now' : 'Scheduled',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isNextMeeting
                                    ? Colors.green.shade700
                                    : Colors.orange.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isNextMeeting
                              ? Colors.white.withOpacity(0.2)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: isNextMeeting
                              ? Colors.white
                              : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Meeting title
                  Text(
                    meeting.topic,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isNextMeeting
                          ? Colors.white
                          : Colors.grey.shade900,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Date and time info
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isNextMeeting
                          ? Colors.white.withOpacity(0.15)
                          : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: isNextMeeting
                              ? Colors.white
                              : Colors.blue.shade700,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '$date • $starttime - $endtime',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isNextMeeting
                                  ? Colors.white
                                  : Colors.blue.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Host info
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isNextMeeting
                              ? Colors.white.withOpacity(0.15)
                              : Colors.purple.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 16,
                          color: isNextMeeting
                              ? Colors.white
                              : Colors.purple.shade700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Host',
                              style: TextStyle(
                                fontSize: 11,
                                color: isNextMeeting
                                    ? Colors.white70
                                    : Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              meeting.staffName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isNextMeeting
                                    ? Colors.white
                                    : Colors.grey.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isNextMeeting
                              ? Colors.white.withOpacity(0.15)
                              : Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 14,
                              color: isNextMeeting
                                  ? Colors.white
                                  : Colors.orange.shade700,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${meeting.duration} min',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isNextMeeting
                                    ? Colors.white
                                    : Colors.orange.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Action button
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: isNextMeeting
                          ? const LinearGradient(
                              colors: [Colors.white, Colors.white],
                            )
                          : LinearGradient(
                              colors: [
                                Colors.blue.shade400,
                                Colors.blue.shade600,
                              ],
                            ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: (isNextMeeting ? Colors.white : Colors.blue)
                              .withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          // Your join logic here
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isNextMeeting
                                  ? Icons.videocam
                                  : Icons.info_outline,
                              color: isNextMeeting
                                  ? Colors.green.shade700
                                  : Colors.white,
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              isNextMeeting ? 'Join Session' : 'View Details',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isNextMeeting
                                    ? Colors.green.shade700
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 180,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 120,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width - 32,
                  margin: EdgeInsets.only(right: index == 0 ? 12 : 0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
