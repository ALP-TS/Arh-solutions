import 'package:arh_solution_app/presentation/common/view/coursedetailpage/course_deatail_page.dart';
import 'package:arh_solution_app/presentation/exam/bindings/examattendbdng.dart';
import 'package:arh_solution_app/presentation/exam/bindings/examlistbdng.dart';
import 'package:arh_solution_app/presentation/exam/bindings/examresultbdng.dart';
import 'package:arh_solution_app/presentation/exam/view/examattend/examattend.dart';
import 'package:arh_solution_app/presentation/exam/view/examattend/src/examinstruction.dart';
import 'package:arh_solution_app/presentation/exam/view/examattend/src/examtimeout.dart';
import 'package:arh_solution_app/presentation/exam/view/examattend/src/examviolation.dart';
import 'package:arh_solution_app/presentation/exam/view/examlist/examlist.dart';
import 'package:arh_solution_app/presentation/exam/view/examsolution/examsolution.dart';
import 'package:get/get.dart';
import 'package:arh_solution_app/app/config/routes/route_name.dart';
import 'package:arh_solution_app/presentation/common/view/dashboard/dashboard.dart';
import '../../../presentation/Learn/bindings/audiolistbdng.dart';
import '../../../presentation/Learn/bindings/coursebinding.dart';
import '../../../presentation/Learn/bindings/notelistbdng.dart';
import '../../../presentation/Learn/bindings/tabbarbdng.dart';
import '../../../presentation/Learn/bindings/videobdng.dart';
import '../../../presentation/Learn/bindings/videoplayerbdng.dart';
import '../../../presentation/Learn/view/notes/src/imageview.dart';
import '../../../presentation/Learn/view/notes/src/pdfview.dart';
import '../../../presentation/Learn/view/studymaterialtab/navigatetostudymaterials.dart';
import '../../../presentation/Learn/view/studymaterialtab/studymaterialtab.dart';
import '../../../presentation/Learn/view/videos/videoplayer/Videolayer_headset.dart';
import '../../../presentation/common/bindings/catorybdng.dart';
import '../../../presentation/common/bindings/splashscreenbdng.dart';
import '../../../presentation/common/bindings/zoombdng.dart';
import '../../../presentation/settings/bndings/profilebdng.dart';
import '../../../presentation/settings/view/settingspageui.dart';
import 'routig_widget.dart';
//*====================> Screen Imports
import 'package:arh_solution_app/presentation/common/view/welomescreen/welcomesreen.dart';

import '../../../presentation/common/view/slashscreen/splashscreen.dart';

import '../../../presentation/common/view/bottombar/bottombar.dart';
import '../../../presentation/Learn/view/subjects/subjectlist.dart';
import '../../../presentation/common/view/login/loginscreen.dart';
import '../../../presentation/Learn/view/topic/topiclist.dart';

//*====================> Binding Imports

import '../../../presentation/Learn/bindings/subjectbdng.dart';

import '../../../presentation/common/bindings/loginbdng.dart';
import '../../../presentation/Learn/bindings/topicbdng.dart';

//?====================> App routes
class AppRoutes {
  static final routes = [
    getPage(RouteName.home, const Splash(), [SplashscreenBdng()]),
    getPage(RouteName.signup, Dashboard(isloggedin: false), [
      Zoombdng(),
      Coursebinding(),
      Catorybdng(),
    ]),
    getPage(
      RouteName.onboard,
      const WelcomeScreen(),
      [],
      Transition.upToDown,
      const Duration(microseconds: 500),
    ),
    getPage(RouteName.login, const LoginPage(), [Loginbdng()]),
    getPage(RouteName.navbar, const BottomBar(), [
      Zoombdng(),
      Coursebinding(),
      Catorybdng(),
    ]),
    getPage(RouteName.sublist, const SubjectList(), [Subjectbdng()]),
    getPage(RouteName.topiclist, const TopicList(), [Topicbdng()]),
    //*====================>  Routes
    getPage(RouteName.examinstruction, const ExamInstructions(), [
      Examattendbdng(),
    ]),

    getPage(RouteName.exampage, const ExamScreen(), []),
    getPage(RouteName.coursedetailpage, const CourseDetailsPage(), []),
    getPage(RouteName.timeout, ModernTimeoutPage(), []),
    getPage(RouteName.examviolation, const ExamViolationScreen(), []),
    getPage(RouteName.listexam, const Examlist(), [Examlistbdng()]),
    getPage(RouteName.examresult, const Examsolution(), [Examresultbdng()]),
    getPage(RouteName.videoplayer, const HeadsetVideoPlayer(), [
      Videoplayerbdng(),
    ]),
    getPage(RouteName.studymaterialtab, const ContentNavigationScreen(), [
      Tabbarbdng(),
      Videobdng(),
      Audiolistbdng(),
      Notelistbdng(),
    ]),
    getPage(RouteName.studymaterials, const StudyMaterialTab(), []),
    getPage(RouteName.pdfview, const PdfView(), []),
    getPage(RouteName.imgview, const ImageView(), []),
    getPage(RouteName.settings, const SettingsPage(), []),
  ];
}
