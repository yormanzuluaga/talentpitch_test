// video_state.dart

part of 'video_bloc.dart';

class VideoState extends Equatable {
  final bool isLoading;
  final bool isPlaying;
  final String? errorMessage;

  final TalentModel? talent;

  final List<DataMost>? talentList;

  const VideoState({
    this.isLoading = false,
    this.errorMessage,
    this.isPlaying = false,
    this.talent,
    this.talentList,
  });

  VideoState copyWith({
    TalentModel? talent,
    bool? isLoading,
    String? errorMessage,
    bool? isPlaying,
    List<DataMost>? talentList,
  }) {
    return VideoState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isPlaying: isPlaying ?? this.isPlaying,
      talent: talent ?? this.talent,
      talentList: talentList ?? this.talentList,
    );
  }

  @override
  List<Object?> get props => [
        talent,
        isLoading,
        errorMessage,
        isPlaying,
        talentList,
      ];
}
