part of 'video_feed_bloc.dart';

@freezed
class VideoFeedEvent with _$VideoFeedEvent {
  const factory VideoFeedEvent.getVideosFromApi() = _GetVideosFromApi;
  const factory VideoFeedEvent.setLoading() = _SetLoading;
  const factory VideoFeedEvent.updateUrls(List<String> urls) = _UpdateUrls;
  const factory VideoFeedEvent.onVideoIndexChanged(int index) =
      _OnVideoIndexChanged;
}
