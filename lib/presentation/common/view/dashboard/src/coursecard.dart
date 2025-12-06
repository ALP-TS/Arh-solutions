// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hugeicons/hugeicons.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:b_soft_appliction/core/res/assets/images.dart';
// import 'package:share_plus/share_plus.dart';

// import '../../../../../app/config/theme/colors.dart';
// import '../../../../../core/helpers/toasthelper.dart';
// import '../../../../../domain/models/courselist_model.dart';
// import '../../../../shared/view/share_button.dart';

// class CourseCard extends StatelessWidget {
//   const CourseCard({super.key, required this.courseListModel});
//   final CourseListModel courseListModel;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 300,
//       // height: 300,
//       child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             border: const Border(
//               bottom: BorderSide(color: AppColors.secondary, width: 2.0),
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Image
//               Stack(
//                 children: [
//                   Container(
//                     height: 150,
//                     width: 300,
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.6),
//                           offset: const Offset(0, 5),
//                           blurRadius: 8,
//                         ),
//                       ],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.vertical(
//                         top: Radius.circular(16),
//                         bottom: Radius.circular(16),
//                       ),
//                       child: FadeInImage.assetNetwork(
//                         placeholder:
//                             AppImages.coursedefault, // Placeholder image path
//                         image: courseListModel.profile, // URL of the image
//                         fit: BoxFit.fitWidth,
//                         imageErrorBuilder: (context, error, stackTrace) {
//                           return Image.asset(
//                             AppImages
//                                 .coursedefault, // Fallback asset image path
//                             fit: BoxFit.cover,
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Align(
//                       alignment: Alignment.topRight,
//                       child: courseListModel.profile == ""
//                           ? ShareButton(
//                               imageAssetPath: AppImages.coursedefault,
//                               textContent:
//                                   '''
// 🚀 Unlock Your Potential with Oyster Academy! 🌟

// 📚 Learn from the Best – Master "${courseListModel.course}" with high-quality lessons by industry experts.

// 🎯 Flexible Learning – Study anytime, anywhere at your own pace.

// 🔥 Exclusive Course: "${courseListModel.course}" – Boost your skills with this certified program.

// ''',
//                               url:
//                                   'https://study.oysteracademy.in/course_details/${courseListModel.siteCourseId}',
//                             )
//                           : ShareButton(
//                               imageNetworkUrl: courseListModel.profile,
//                               textContent:
//                                   '''
// 🚀 Unlock Your Potential with Oyster Academy! 🌟

// 📚 Learn from the Best – Master "${courseListModel.course}" with high-quality lessons by industry experts.

// 🎯 Flexible Learning – Study anytime, anywhere at your own pace.

// 🔥 Exclusive Course: "${courseListModel.course}" – Boost your skills with this certified program.

// ''',
//                               url:
//                                   'https://study.oysteracademy.in/course_details/${courseListModel.siteCourseId}',
//                             ),
//                     ),
//                   ),
//                 ],
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Category
//                     Text(
//                       courseListModel.course,
//                       style: TextStyle(
//                         color: Colors.green,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                     const SizedBox(height: 6),

//                     // Title
//                     Text(
//                       courseListModel.subName,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     // Footer Row
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.menu_book_outlined,
//                           size: 18,
//                           color: Colors.grey,
//                         ),
//                         const SizedBox(width: 4),
//                         Text("23 Lesson"),
//                         const Spacer(),
//                         Icon(
//                           Icons.people_outline,
//                           size: 18,
//                           color: Colors.grey,
//                         ),
//                         const SizedBox(width: 4),
//                         Text("15 Students"),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
