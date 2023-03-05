import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pseudo_hot_not/video_feed/bloc/video_feed_bloc.dart';
import 'package:pseudo_hot_not/video_feed/repsoitory/video_feed_repository.dart';

class BlocInjection extends StatelessWidget {
  final Widget child;

  const BlocInjection({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VideoFeedBloc(
            RepositoryProvider.of<VideoFeedRepsoitory>(
              context,
              listen: false,
            ),
          ),
        )
      ],
      child: child,
    );
  }
}
