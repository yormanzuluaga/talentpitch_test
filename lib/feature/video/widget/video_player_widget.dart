import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talentpitch_test/feature/video/bloc/video_bloc.dart';
import 'package:talentpitch_ui/talentpitch_ui.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String about;
  final String name;
  final String avatar;
  final VoidCallback onVideoEnded;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    required this.about,
    required this.name,
    required this.avatar,
    required this.onVideoEnded,
  });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  Timer? _iconTimer;
  bool _showPauseIcon = false;
  bool isPlaying = false;
  bool _isVideoInitialized = false;
  bool _hasError = false;

  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void dispose() {
    _iconTimer?.cancel();
    _videoPlayerController.dispose();
    _videoPlayerController.removeListener(_onVideoPositionChanged);

    super.dispose();
  }

  Future<void> _initializeVideo() async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
      await _videoPlayerController.initialize();
      setState(() {
        _isVideoInitialized = true;
      });
      _videoPlayerController.play(); // Reproduce el video automáticamente
      _videoPlayerController.addListener(_onVideoPositionChanged);
    } catch (e) {
      setState(() {
        _hasError = true; // Indica que hubo un error
      });
    }
  }

  void _showPauseIconTemporarily() {
    setState(() {
      _showPauseIcon = true;
    });

    _iconTimer?.cancel();

    _iconTimer = Timer(Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _showPauseIcon = false;
        });
      }
    });
  }

  void _onVideoPositionChanged() {
    // Verificar si el video ha terminado
    if (_videoPlayerController.value.position >= _videoPlayerController.value.duration) {
      widget.onVideoEnded(); // Llamar al callback cuando el video termina
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        if (!_isVideoInitialized) {
          return Center(child: CircularProgressIndicator());
        }
        if (_hasError) {
          Center(
            child: BaseCard(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            widget.avatar,
                          ),
                          radius: 24,
                        ),
                        SizedBox(
                          width: AppSpacing.md,
                        ),
                        Text(
                          widget.name,
                          style: UITextStyle.labels.label.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Descripción de pitch: ',
                        style: UITextStyle.titles.title3Medium.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Text(
                      widget.about,
                      style: UITextStyle.labels.label.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ), // Muestra un mensaje de error
          );
        }
        return GestureDetector(
          onTap: () {
            if (_videoPlayerController.value.isPlaying) {
              _videoPlayerController.pause();
              context.read<VideoBloc>().add(PlayAndPauseVideosEvent());
            } else {
              _videoPlayerController.play();
              context.read<VideoBloc>().add(PlayAndPauseVideosEvent());
              _showPauseIconTemporarily();
            }
          },
          child: Stack(
            children: [
              VideoPlayer(_videoPlayerController),
              if (state.isPlaying)
                Center(
                  child: Icon(
                    Icons.play_arrow,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              if (_showPauseIcon && !state.isPlaying)
                Center(
                  child: Icon(
                    Icons.pause,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
