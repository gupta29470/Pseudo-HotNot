import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pseudo_hot_not/video_feed/bloc/video_feed_bloc.dart';

extension BuildContextX on BuildContext {
  VideoFeedBloc get videoFeedBloc => read<VideoFeedBloc>();
}
