import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pseudo_hot_not/common/extensions.dart';
import 'package:pseudo_hot_not/video_feed/bloc/video_feed_bloc.dart';
import 'package:pseudo_hot_not/video_feed/widgets/video_widget.dart';

class VideoFeedScreen extends StatefulWidget {
  const VideoFeedScreen({super.key});

  @override
  State<VideoFeedScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  @override
  void didChangeDependencies() {
    context.videoFeedBloc.add(
      const VideoFeedEvent.getVideosFromApi(),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<VideoFeedBloc, VideoFeedState>(
          builder: ((context, state) {
            return PageView.builder(
              itemCount: state.urls.length,
              scrollDirection: Axis.vertical,
              itemBuilder: ((context, index) {
                final bool isLoading =
                    (state.isLoading && index == state.urls.length - 1);

                return state.focusedIndex == index
                    ? VideoWidget(
                        isLoading: isLoading,
                        controller: state.controllers[index]!,
                      )
                    : const SizedBox.shrink();
              }),
              onPageChanged: (value) {
                context.videoFeedBloc.add(
                  VideoFeedEvent.onVideoIndexChanged(
                    value,
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
