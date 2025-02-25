import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talentpitch_test/app/routes/router_snack_bar.dart';
import 'package:talentpitch_test/feature/main_dashboard/bloc/category_bloc.dart';
import 'package:talentpitch_test/feature/video/bloc/video_bloc.dart';
import 'package:talentpitch_test/feature/video/widget/video_player_widget.dart';
import 'package:talentpitch_ui/talentpitch_ui.dart';

class VideoMobile extends StatefulWidget {
  const VideoMobile({Key? key}) : super(key: key);

  @override
  _VideoMobileState createState() => _VideoMobileState();
}

class _VideoMobileState extends State<VideoMobile> {
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
    } else {
      context.read<CategoryBloc>().add(AnotherVideoEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        return state.talent != null
            ? Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: AppColors.white,
                      )),
                ),
                body: Column(
                  children: [
                    Text(
                      state.talent!.title.toString(),
                      style: UITextStyle.titles.title3Medium,
                    ),
                    if (state.talent!.data!.isNotEmpty)
                      Flexible(
                        child: PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: state.talent!.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final data = state.talent!.data![index];

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
                                        backgroundImage: NetworkImage(
                                          data.avatar.toString(),
                                        ),
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
                                      context.read<VideoBloc>().add(AddPlayListVideosEvent(talentList: data));
                                      RouterSnackBar.info(message: 'Agregaste a tu playlist este video');
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline_outlined,
                                      color: AppColors.white,
                                      size: 36,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
