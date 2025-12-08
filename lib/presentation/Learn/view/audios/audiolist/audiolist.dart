import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arh_solution_app/presentation/shared/view/nodatafound.dart';

import '../../../../../app/Di/dimensions.dart';
import '../../../../shared/view/animatedlistview.dart';
import '../../../viewmodel/audiolistvm.dart';
import 'src/listitem.dart';

class Audiolist extends StatelessWidget {
  const Audiolist({super.key});

  @override
  Widget build(BuildContext context) {
    final audioVM = Get.find<Audiolistvm>();
    return Obx(
      () =>
          // audioVM.videoList.isEmpty &&
          audioVM.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Center(child: Emptypage()),
      // : Padding(
      //     padding: EdgeInsets.only(
      //         top: Di.screenWidth * 0.02,
      //         left: Di.screenWidth * 0.02,
      //         right: Di.screenWidth * 0.02),
      //     child: AnimatedListView(
      //       itemcount: 10,
      //       // audioVM.videoList.length,
      //       itemBuilder: (context, index, animation) {
      //         return FadeTransition(
      //           opacity:
      //               animation.drive(CurveTween(curve: Curves.easeIn)),
      //           child: PremiumAudioListItem(
      //               // videoData: videoVM.videoList[index],
      //               ),
      //         );
      //       },
      //     ),
      //   ),
    );
  }
}
