import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pseudo_hot_not/video_feed/repsoitory/video_feed_repository.dart';

class RepositoryInjection extends StatelessWidget {
  final Widget child;

  const RepositoryInjection({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => VideoFeedRepsoitory(),
        ),
      ],
      child: child,
    );
  }
}
