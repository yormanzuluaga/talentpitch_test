// video_event.dart
part of 'video_bloc.dart';

sealed class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class FetchVideosEvent extends VideoEvent {
  const FetchVideosEvent({
    required this.url,
  });

  final String url;

  @override
  List<Object> get props => [url];
}

class PlayAndPauseVideosEvent extends VideoEvent {
  const PlayAndPauseVideosEvent();

  @override
  List<Object> get props => [];
}

class PlayListVideosEvent extends VideoEvent {
  const PlayListVideosEvent();

  @override
  List<Object> get props => [];
}

class AddPlayListVideosEvent extends VideoEvent {
  const AddPlayListVideosEvent({
    required this.talentList,
  });

  final DataMost talentList;

  @override
  List<Object> get props => [talentList];
}

class RemoverPlayListVideosEvent extends VideoEvent {
  const RemoverPlayListVideosEvent({
    required this.talentList,
  });

  final DataMost talentList;

  @override
  List<Object> get props => [talentList];
}
