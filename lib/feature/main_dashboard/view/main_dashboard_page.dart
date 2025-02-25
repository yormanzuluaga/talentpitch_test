import 'package:flutter/material.dart';
import 'package:talentpitch_test/feature/main_dashboard/view/main_dashboard_desktop.dart';
import 'package:talentpitch_test/feature/main_dashboard/view/main_dashboard_mobile.dart';

class MainDashboardPage extends StatelessWidget {
  const MainDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MediaQuery.of(context).size.width > 900
            ? const MainDashboardDesktop()
            : MainDashboardMobile();
      },
    );
  }
}
