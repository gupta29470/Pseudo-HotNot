import 'package:pseudo_hot_not/common/constants.dart';
import 'package:pseudo_hot_not/video_feed/models/video_feed_data.dart';

class VideoFeedRepsoitory {
  static const String tag = "VideoFeedRepsoitory";

  Future<List<String>> getVideos({int id = 0}) async {
    int length = VideoFeedData.videoFeedData.length;

    // No more videos
    if ((id >= length)) {
      return [];
    }

    // await Future.delayed(const Duration(milliseconds: kLatency));

    if ((id + Constants.videoFetchLimit >= length)) {
      return VideoFeedData.videoFeedData.sublist(id, length);
    }

    return VideoFeedData.videoFeedData
        .sublist(id, id + Constants.videoFetchLimit);
  }
}
