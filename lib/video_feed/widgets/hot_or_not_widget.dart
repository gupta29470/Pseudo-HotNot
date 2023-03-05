import 'package:flutter/material.dart';
import 'package:pseudo_hot_not/styles/colors/app_color_helper.dart';
import 'package:pseudo_hot_not/styles/themes/text_theme_helper.dart';
import 'package:video_player/video_player.dart';

class HotOrNotWidget extends StatefulWidget {
  final VideoPlayerController controller;

  const HotOrNotWidget({
    super.key,
    required this.controller,
  });

  @override
  State<HotOrNotWidget> createState() => _HotOrNotWidgetState();
}

class _HotOrNotWidgetState extends State<HotOrNotWidget> {
  ValueNotifier<bool> soundNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 28,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.abc,
              color: Colors.transparent,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              "Hot or Not",
              style: TextThemeHelper.white_12_500,
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: soundNotifier,
            builder: (_, value, __) {
              return IconButton(
                onPressed: muteUnmute,
                icon: Icon(
                  value ? Icons.volume_up : Icons.volume_mute,
                  color: AppColorHelper.white,
                ),
                color: AppColorHelper.white,
              );
            },
          ),
        ],
      ),
    );
  }
}

extension on _HotOrNotWidgetState {
  void muteUnmute() {
    if (soundNotifier.value) {
      widget.controller.setVolume(0);
    } else {
      widget.controller.setVolume(1);
    }
    soundNotifier.value = !soundNotifier.value;
  }
}
