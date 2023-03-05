import 'package:flutter/material.dart';
import 'package:pseudo_hot_not/dependency_injection/bloc_injection.dart';
import 'package:pseudo_hot_not/dependency_injection/repository_injection.dart';
import 'package:pseudo_hot_not/video_feed/screens/video_feed_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const RepositoryInjection(
      child: BlocInjection(
        child: MaterialApp(
          title: 'Pseudo HotorNot',
          home: VideoFeedScreen(),
        ),
      ),
    );
  }
}
