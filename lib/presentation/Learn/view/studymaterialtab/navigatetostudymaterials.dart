import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arh_solution_app/core/helpers/appbarhelper.dart';

import '../../../../app/config/routes/route_name.dart';
import '../../../../app/config/theme/colors.dart';
import '../../../../app/config/theme/text.dart';

class ContentNavigationScreen extends StatelessWidget {
  // ignore: use_super_parameters
  const ContentNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: Appbarhelper.pageAppbar(title: 'learning Hub'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            AppTextHelper.subHead(
              text: 'Choose your learning content',
              fcolor: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 3.5,
                mainAxisSpacing: 20,
                children: [
                  _buildContentCard(
                    context: context,
                    title: 'Video Lectures',
                    subtitle: 'Watch interactive video content',
                    icon: Icons.play_circle_fill,
                    color: AppColors.primary,
                    onTap: () => _navigateToVideo(context),
                  ),
                  _buildContentCard(
                    context: context,
                    title: 'Study Notes',
                    subtitle: 'Read comprehensive  materials',
                    icon: Icons.menu_book,
                    color: AppColors.secondary,
                    onTap: () => _navigateToNotes(context),
                  ),
                  _buildContentCard(
                    context: context,
                    title: 'Audio Content',
                    subtitle: 'Listen to podcasts and lectures',
                    icon: Icons.headphones,
                    color: AppColors.success,
                    onTap: () => _navigateToAudio(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, color: AppColors.white, size: 30),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextHelper.subHead(
                        text: title,
                        fcolor: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 5),
                      AppTextHelper.caption(
                        text: subtitle,
                        fcolor: AppColors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: color, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToVideo(BuildContext context) {
    Get.toNamed(RouteName.studymaterials, arguments: 'Videos');
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const VideoScreen(),
    //   ),
    // );
  }

  void _navigateToNotes(BuildContext context) {
    Get.toNamed(RouteName.studymaterials, arguments: 'Notes');
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const NotesScreen(),
    //   ),
    // );
  }

  void _navigateToAudio(BuildContext context) {
    Get.toNamed(RouteName.studymaterials, arguments: 'Audios');
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const AudioScreen(),
    //   ),
    // );
  }
}
