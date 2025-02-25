import 'dart:convert';

import 'package:api_helper/api_helper.dart';
import 'package:api_repository/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talentpitch_test/core/database/play_list_store.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final int videosPerPage = 2; // Cantidad de videos por página
  int currentPage = 0;
  bool hasMore = true;

  VideoBloc({
    required VideoRepository videoRepository,
  })  : _videoRepository = videoRepository,
        super(VideoState()) {
    on<FetchVideosEvent>(_onFetchVideos);

    on<PlayAndPauseVideosEvent>(_onPlayAndPauseVideos);

    on<PlayListVideosEvent>(_onPlayListVideosEvent);

    on<AddPlayListVideosEvent>(_onAddPlayListVideosEvent);

    on<RemoverPlayListVideosEvent>(_onRemovePlayListVideosEvent);
  }
  final VideoRepository _videoRepository;

  Future<void> _onFetchVideos(FetchVideosEvent event, Emitter<VideoState> emit) async {
    final result = await _videoRepository.getMostHighlightTalent(url: event.url);

    result.fold((l) {}, (r) {
      emit(state.copyWith(talent: r));
    });
  }

  Future<void> _onPlayAndPauseVideos(PlayAndPauseVideosEvent event, Emitter<VideoState> emit) async {
    if (!state.isPlaying) {
      emit(state.copyWith(isPlaying: true));
    } else {
      emit(state.copyWith(isPlaying: false));
    }
  }

  Future<void> _onPlayListVideosEvent(PlayListVideosEvent event, Emitter<VideoState> emit) async {
    final playListStore = PlayListStore.instance;
    if (playListStore.playList.isNotEmpty) {
      final playList = (jsonDecode(playListStore.playList) as List).map((e) => DataMost.fromJson(e)).toList();
      emit(state.copyWith(talentList: playList));
    }
  }

  Future<void> _onAddPlayListVideosEvent(AddPlayListVideosEvent event, Emitter<VideoState> emit) async {
    List<DataMost> data = [];
    final playListStore = PlayListStore.instance;
    if (playListStore.playList.isEmpty) {
      data.add(event.talentList);
      await playListStore.savedPlayLaist(playList: jsonEncode(data));
      emit(state.copyWith(talentList: data));
    } else {
      final playList = (jsonDecode(playListStore.playList) as List).map((e) => DataMost.fromJson(e)).toList();

      final resultado = playList.where((item) => item.id == event.talentList.id);
      if (resultado.isEmpty) {
        playList.add(event.talentList);
        await playListStore.savedPlayLaist(playList: jsonEncode(playList));
        emit(state.copyWith(talentList: data));
      }
    }
  }

  Future<void> _onRemovePlayListVideosEvent(RemoverPlayListVideosEvent event, Emitter<VideoState> emit) async {
    final playListStore = PlayListStore.instance;
    if (playListStore.playList.isNotEmpty) {
      final playList = (jsonDecode(playListStore.playList) as List).map((e) => DataMost.fromJson(e)).toList();

      playList.removeWhere((item) => item.id == event.talentList.id);
      if (playList.isEmpty) {
        await playListStore.removerPlayLaist();
        emit(state.copyWith(talentList: playList));
      } else {
        await playListStore.savedPlayLaist(playList: jsonEncode(playList));
        emit(state.copyWith(talentList: playList));
      }
    }
  }
}
