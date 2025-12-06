import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/audios/audiolist/audiolist.dart';
import '../view/notes/notelist/notelist.dart';
import '../view/videos/videolist/videolist.dart';

class Tabviewvm extends GetxController {
  RxString selectedTab = 'Videos'.obs;
  List<String> tabs = ['Videos', 'Audios', 'Notes'];
  // void updateselection(String tab) {
  //   selectedTab.value = tab;
  // }

  Widget getpage(String page) {
    if (page == 'Videos') {
      return const VideoList();
    } else if (page == 'Audios') {
      return const Audiolist();
    } else {
      return const NoteList();
    }
  }
}
