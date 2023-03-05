import 'package:flutter/material.dart';
import 'package:pseudo_hot_not/styles/colors/app_color_helper.dart';
import 'package:pseudo_hot_not/styles/themes/text_theme_helper.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundColor: AppColorHelper.white,
          child: CircleAvatar(
            radius: 19,
            backgroundImage: NetworkImage(
              "https://i.pravatar.cc/150?img=43",
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Natasha009",
              style: TextThemeHelper.white_16_500,
            ),
            Row(
              children: [
                const Icon(
                  Icons.visibility,
                  color: AppColorHelper.white,
                ),
                const SizedBox(width: 12),
                Text(
                  "2500",
                  style: TextThemeHelper.white_12_400,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
