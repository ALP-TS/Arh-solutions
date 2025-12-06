import 'package:b_soft_appliction/app/config/routes/route_name.dart'
    show RouteName;
import 'package:b_soft_appliction/presentation/common/view/coursedetailpage/course_deatail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b_soft_appliction/app/config/theme/colors.dart';
import 'package:b_soft_appliction/core/res/assets/images.dart';
import 'package:b_soft_appliction/domain/models/courselist_model.dart';
import 'package:b_soft_appliction/presentation/common/view/dashboard/src/tst.dart';
import 'package:b_soft_appliction/presentation/common/view/signupform.dart';
import 'package:shimmer/shimmer.dart'; // Add this to your pubspec.yaml

import '../../../viewmodel/categoryvm.dart';
import 'coursecard.dart';

// class CourseGrid extends StatelessWidget {
//   const CourseGrid({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final categoryVM = Get.find<CategoryVM>();

//     return Obx(() {
//       if (categoryVM.isLoading.value) {
//         return _buildShimmerEffect();
//       } else {
//         return _buildCourseGrid(categoryVM, categoryVM.selectedCategory.value);
//       }
//     });
//   }

//   Widget _buildCourseGrid(CategoryVM categoryVM, String selectedCategory) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: List.generate(
//           categoryVM.courseList.length,
//           (index) {
//             // Show all items if selectedCategory is "All" or empty,
//             // or if the item matches the selected category
//             if (selectedCategory.isNotEmpty &&
//                 selectedCategory != "All" &&
//                 categoryVM.courseList[index].subName != selectedCategory) {
//               return const SizedBox.shrink();
//             }
//             return Padding(
//               padding: const EdgeInsets.only(right: 12),
//               child: CourseCard(courseListModel: categoryVM.courseList[index]),
//             );
//           },
//         )
//             .where((widget) => widget is! SizedBox)
//             .toList(), // Remove empty widgets
//       ),
//     );
//   }

//   Widget _buildShimmerEffect() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: List.generate(
//           4, // Show 4 shimmer placeholders
//           (index) => Padding(
//             padding: const EdgeInsets.only(right: 12),
//             child: Shimmer.fromColors(
//               baseColor: Colors.grey[300]!,
//               highlightColor: Colors.grey[100]!,
//               child: Container(
//                 width: 200, // Match your CourseCard width
//                 height: 240, // Match your CourseCard height
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class CourseGrid extends StatelessWidget {
  const CourseGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryVM = Get.find<CategoryVM>();
    return Obx(() {
      if (categoryVM.isLoading.value) {
        return _buildShimmerEffect();
      } else {
        return _buildCourseGrid(categoryVM, categoryVM.selectedCategory.value);
      }
    });
  }

  Widget _buildCourseGrid(CategoryVM categoryVM, String selectedCategory) {
    final filteredCourses = categoryVM.courseList.where((course) {
      return selectedCategory.isEmpty ||
          selectedCategory == "All" ||
          course.subName == selectedCategory;
    }).toList();

    if (filteredCourses.isEmpty) {
      return Container(
        height: 280,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.shade100, width: 2),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school_outlined,
                size: 60,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                'No courses found',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Try selecting a different category',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
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
                      colors: [Colors.orange.shade400, Colors.orange.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.book, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Available Courses',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      '${filteredCourses.length} courses',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: filteredCourses.asMap().entries.map((entry) {
                final index = entry.key;
                final course = entry.value;
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == filteredCourses.length - 1 ? 0 : 16,
                  ),
                  child: _buildModernCourseCard(course),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernCourseCard(CourseListModel courseListModel) {
    return InkWell(
      onTap: () {
        Get.to(() => FormView());
      },
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RouteName.coursedetailpage,
          arguments: courseListModel.siteCourseId);
        },

        child: Container(
          width: 220,
          height: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),

            boxShadow: [
              BoxShadow(
                color: AppColors.white.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // ===== Background Image =====
                // Positioned.fill(
                //   child: Image.network(
                //     courseListModel.profile,
                //     // AppImages.cardimg,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                Positioned.fill(
                  child:
                      (courseListModel.profile != null &&
                          courseListModel.profile!.isNotEmpty)
                      ? Image.network(
                          courseListModel.profile!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              courseListModel.profile,

                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(AppImages.coursedefault, fit: BoxFit.cover),
                ),

                // ===== Gradient Overlay =====
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          // AppColors.primary.withOpacity(0.85),
                          Colors.black.withOpacity(0.80),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // ===== Decorative Circles =====
                // Positioned(
                //   right: -20,
                //   top: -20,
                //   child: Container(
                //     width: 100,
                //     height: 100,
                //     decoration: BoxDecoration(
                //       color: AppColors.lightprimary.withOpacity(0.35),
                //       shape: BoxShape.circle,
                //     ),
                //   ),
                // ),
                // Positioned(
                //   left: -10,
                //   bottom: 60,
                //   child: Container(
                //     width: 60,
                //     height: 60,
                //     decoration: BoxDecoration(
                //       color: AppColors.lightprimary.withOpacity(0.25),
                //       shape: BoxShape.circle,
                //     ),
                //   ),
                // ),

                // ===== Card Content =====
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Category Badge ---
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 6,
                                width: 6,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                courseListModel.subName,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(),

                      // --- Course Icon ---
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          _getIconForCourse(courseListModel.subName),
                          color: AppColors.primary,
                          size: 28,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // --- Course Title ---
                      Text(
                        courseListModel.course ?? 'Course Title',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // --- Course Stats ---
                      Row(
                        children: [
                          _buildStatChip(
                            Icons.play_circle_outline,
                            '${courseListModel.lectures} Lessons',
                          ),
                          const SizedBox(width: 8),
                          _buildStatChip(Icons.access_time, '4h 30m'),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // --- Action Button ---
                      // Container(
                      //   width: double.infinity,
                      //   height: 44,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(14),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.black.withOpacity(0.1),
                      //         blurRadius: 8,
                      //         offset: const Offset(0, 4),
                      //       ),
                      //     ],
                      //   ),
                      //   child: Material(
                      //     color: Colors.transparent,
                      //     child: InkWell(
                      //       borderRadius: BorderRadius.circular(14),
                      //       onTap: () {
                      //         // Navigate to course details
                      //       },
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Icon(
                      //             Icons.arrow_forward,
                      //             color: AppColors.primary,
                      //             size: 18,
                      //           ),
                      //           const SizedBox(width: 8),
                      //           Text(
                      //             'View Course',
                      //             style: TextStyle(
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.bold,
                      //               color: AppColors.primary,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // List<Color> _getGradientForCourse(String? category) {
  //   switch (category?.toLowerCase()) {
  //     case 'mathematics':
  //     case 'math':
  //       return [Colors.blue.shade400, Colors.blue.shade600];
  //     case 'science':
  //       return [Colors.green.shade400, Colors.green.shade600];
  //     case 'english':
  //     case 'language':
  //       return [Colors.purple.shade400, Colors.purple.shade600];
  //     case 'history':
  //       return [Colors.orange.shade400, Colors.orange.shade600];
  //     case 'arts':
  //       return [Colors.pink.shade400, Colors.pink.shade600];
  //     case 'technology':
  //     case 'computer':
  //       return [Colors.teal.shade400, Colors.teal.shade600];
  //     default:
  //       return [Colors.indigo.shade400, Colors.indigo.shade600];
  //   }
  // }

  IconData _getIconForCourse(String? category) {
    switch (category?.toLowerCase()) {
      case 'mathematics':
      case 'math':
        return Icons.calculate;
      case 'science':
        return Icons.science;
      case 'english':
      case 'language':
        return Icons.menu_book;
      case 'history':
        return Icons.history_edu;
      case 'arts':
        return Icons.palette;
      case 'technology':
      case 'computer':
        return Icons.computer;
      default:
        return Icons.school;
    }
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
                        width: 150,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 80,
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.only(right: index == 2 ? 0 : 16),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 220,
                      height: 280,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
