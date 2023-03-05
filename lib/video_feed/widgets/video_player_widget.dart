import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final bool isLoading;
  final VideoPlayerController controller;

  const VideoPlayerWidget({
    super.key,
    required this.isLoading,
    required this.controller,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  ValueNotifier<bool> playNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: playPauseVideo,
      child: Column(
        children: [
          Expanded(child: VideoPlayer(widget.controller)),
          AnimatedCrossFade(
            alignment: Alignment.bottomCenter,
            sizeCurve: Curves.decelerate,
            duration: const Duration(milliseconds: 400),
            firstChild: const Padding(
              padding: EdgeInsets.all(10.0),
              child: CupertinoActivityIndicator(
                color: Colors.white,
                radius: 8,
              ),
            ),
            secondChild: const SizedBox.shrink(),
            crossFadeState: widget.isLoading
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        ],
      ),
    );
  }
}

extension on _VideoPlayerWidgetState {
  void playPauseVideo() {
    if (playNotifier.value) {
      widget.controller.pause();
    } else {
      widget.controller.play();
    }

    playNotifier.value = !playNotifier.value;
  }
}
