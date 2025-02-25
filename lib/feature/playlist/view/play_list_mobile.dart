import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talentpitch_test/feature/video/bloc/video_bloc.dart';
import 'package:talentpitch_test/feature/video/widget/video_player_widget.dart';
import 'package:talentpitch_ui/talentpitch_ui.dart';

class PlayListMobile extends StatefulWidget {
  const PlayListMobile({Key? key}) : super(key: key);

  @override
  _PlayListMobileState createState() => _PlayListMobileState();
}

class _PlayListMobileState extends State<PlayListMobile> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onVideoEnded() {
    // Avanzar al siguiente video
    final currentPage = _pageController.page?.round() ?? 0;
    if (currentPage < (context.read<VideoBloc>().state.talent?.data?.length ?? 0) - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300), // Duración de la animación
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        return Column(
          children: [
            state.talentList != null && state.talentList!.isNotEmpty
                ? Flexible(
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: state.talentList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final data = state.talentList![index];
                        return Stack(
                          children: [
                            VideoPlayerWidget(
                              videoUrl: data.videoUrl.toString(),
                              about: data.about.toString(),
                              name: data.name.toString(),
                              avatar: data.avatar.toString(),
                              onVideoEnded: _onVideoEnded,
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(data.avatar.toString()),
                                    radius: 24,
                                  ),
                                  SizedBox(
                                    width: AppSpacing.sm,
                                  ),
                                  Text(
                                    data.name.toString(),
                                    style: UITextStyle.labels.label,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 20,
                              child: IconButton(
                                onPressed: () {
                                  context.read<VideoBloc>().add(RemoverPlayListVideosEvent(talentList: data));
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline_outlined,
                                  color: AppColors.white,
                                  size: 36,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  )
                : Text(
                    'No tienes videos guardados',
                    style: UITextStyle.labels.label,
                  )
          ],
        );
      },
    );
  }
}
