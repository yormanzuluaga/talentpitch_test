import 'package:flutter/material.dart';
import 'package:talentpitch_test/feature/video/view/video_desktop.dart';
import 'package:talentpitch_test/feature/video/view/video_mobile.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MediaQuery.of(context).size.width > 900 ? VideoDesktop() : VideoMobile();
      },
    );
  }
}
