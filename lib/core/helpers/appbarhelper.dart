import 'package:arh_solution_app/core/utils/appbar/appbartypes.dart';

class Appbarhelper {
  static PageAppBar pageAppbar({required String title, bool leading = true}) {
    return PageAppBar(title: title, leading: leading);
  }

  static Dashboardappbar dashboardAppbar(
    String name,
    email, {
    bool isloggedin = true,
  }) {
    return Dashboardappbar(name: name, email: email, isloggedin: isloggedin);
  }
}
