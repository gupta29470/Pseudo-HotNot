import 'package:flutter/material.dart';
import 'package:pseudo_hot_not/styles/colors/app_color_helper.dart';

class BottomIconWidget extends StatelessWidget {
  final IconData iconData;

  const BottomIconWidget({
    super.key,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: AppColorHelper.white,
      size: 32,
    );
  }
}
