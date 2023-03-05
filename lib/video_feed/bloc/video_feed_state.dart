part of 'video_feed_bloc.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class VideoFeedState with _$VideoFeedState {
  factory VideoFeedState({
    required List<String> urls,
    required Map<int, VideoPlayerController> controllers,
    required int focusedIndex,
    required int reloadCounter,
    required bool isLoading,
  }) = _VideoFeedState;

  factory VideoFeedState.initial() => VideoFeedState(
        focusedIndex: 0,
        reloadCounter: 0,
        isLoading: false,
        urls: [],
        controllers: {},
      );
}
