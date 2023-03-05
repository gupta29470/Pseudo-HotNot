import 'package:flutter/material.dart';
import 'package:pseudo_hot_not/styles/colors/app_color_helper.dart';
import 'package:pseudo_hot_not/styles/themes/text_theme_helper.dart';
import 'package:pseudo_hot_not/video_feed/widgets/bottom_icon_widget.dart';
import 'package:pseudo_hot_not/video_feed/widgets/hot_or_not_widget.dart';
import 'package:pseudo_hot_not/video_feed/widgets/profile_widget.dart';
import 'package:pseudo_hot_not/video_feed/widgets/video_player_widget.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final bool isLoading;
  final VideoPlayerController controller;

  const VideoWidget({
    super.key,
    required this.isLoading,
    required this.controller,
  });

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        VideoPlayerWidget(
          isLoading: widget.isLoading,
          controller: widget.controller,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HotOrNotWidget(controller: widget.controller),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: AppColorHelper.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.share,
                        color: AppColorHelper.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const ProfileWidget(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lorem ipsum dolor sit amet .....",
                        style: TextThemeHelper.white_12_500,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      BottomIconWidget(
                        iconData: Icons.home,
                      ),
                      BottomIconWidget(
                        iconData: Icons.search,
                      ),
                      Icon(
                        Icons.add_circle_rounded,
                        color: Colors.orange,
                        size: 40,
                      ),
                      BottomIconWidget(
                        iconData: Icons.wallet,
                      ),
                      BottomIconWidget(
                        iconData: Icons.miscellaneous_services,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
