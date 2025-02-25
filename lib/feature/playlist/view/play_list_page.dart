import 'package:flutter/material.dart';
import 'package:talentpitch_test/feature/playlist/view/play_list_desktop.dart';
import 'package:talentpitch_test/feature/playlist/view/play_list_mobile.dart';

class PlayListPage extends StatelessWidget {
  const PlayListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MediaQuery.of(context).size.width > 900 ? PlayListDesktop() : PlayListMobile();
      },
    );
  }
}
