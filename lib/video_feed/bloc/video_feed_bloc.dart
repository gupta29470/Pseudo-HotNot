import 'dart:developer';
import 'dart:isolate';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pseudo_hot_not/common/constants.dart';
import 'package:pseudo_hot_not/video_feed/repsoitory/video_feed_repository.dart';
import 'package:video_player/video_player.dart';

part 'video_feed_event.dart';
part 'video_feed_state.dart';
part 'video_feed_bloc.freezed.dart';

class VideoFeedBloc extends Bloc<VideoFeedEvent, VideoFeedState> {
  final VideoFeedRepsoitory _videoFeedRepsoitory;

  VideoFeedBloc(this._videoFeedRepsoitory)
      : super(
          VideoFeedState.initial(),
        ) {
    on<_SetLoading>(
      (event, emit) {
        emit(
          state.copyWith(
            isLoading: true,
          ),
        );
      },
    );
    on<_GetVideosFromApi>(
      (event, emit) async {
        final List<String> urls = await _videoFeedRepsoitory.getVideos();
        state.urls.addAll(urls);

        await _initializeControllerAtIndex(0);

        _playControllerAtIndex(0);

        await _initializeControllerAtIndex(1);

        emit(state.copyWith(reloadCounter: state.reloadCounter + 1));
      },
    );

    on<_UpdateUrls>(
      (event, emit) {
        emit(state.copyWith(
          urls: event.urls,
        ));
      },
    );

    on<_OnVideoIndexChanged>(
      (event, emit) {
        bool fetchMore = event.index == (state.urls.length / 2);
        if (fetchMore) {
          videoIsolate(
            event.index,
          );
        }

        if (event.index > state.focusedIndex) {
          _playNext(event.index);
        } else {
          _playPrevious(event.index);
        }

        emit(state.copyWith(
          focusedIndex: event.index,
        ));
      },
    );
  }

  void _playNext(int index) {
    _stopControllerAtIndex(index - 1);

    _disposeControllerAtIndex(index - 2);

    _playControllerAtIndex(index);

    _initializeControllerAtIndex(index + 1);
  }

  void _playPrevious(int index) {
    _stopControllerAtIndex(index + 1);

    _disposeControllerAtIndex(index + 2);

    _playControllerAtIndex(index);

    _initializeControllerAtIndex(index - 1);
  }

  Future _initializeControllerAtIndex(int index) async {
    if (index < state.urls.length && index >= 0) {
      VideoPlayerController videoPlayerController =
          VideoPlayerController.network(
        state.urls[index],
      );

      state.controllers[index] = videoPlayerController;

      await videoPlayerController.initialize().then(
            (value) => videoPlayerController.setLooping(
              true,
            ),
          );

      log('🚀🚀🚀 INITIALIZED $index');
    }
  }

  void _playControllerAtIndex(int index) {
    if (index < state.urls.length && index >= 0) {
      final VideoPlayerController videoPlayerController =
          state.controllers[index]!;

      videoPlayerController.play();

      log('🚀🚀🚀 PLAYING $index');
    }
  }

  void _stopControllerAtIndex(int index) {
    if (index < state.urls.length && index >= 0) {
      final VideoPlayerController videoPlayerController =
          state.controllers[index]!;

      videoPlayerController.pause();

      //  videoPlayerController.seekTo(const Duration());

      log('🚀🚀🚀 STOPPED $index');
    }
  }

  void _disposeControllerAtIndex(int index) {
    if (index < state.urls.length && index >= 0) {
      final VideoPlayerController? videoPlayerController =
          state.controllers[index];

      videoPlayerController?.dispose();

      if (videoPlayerController != null) {
        state.controllers.remove(videoPlayerController);
      }

      log('🚀🚀🚀 DISPOSED $index');
    }
  }

  Future videoIsolate(int index) async {
    add(
      const VideoFeedEvent.setLoading(),
    );

    ReceivePort mainReceivePort = ReceivePort();

    Isolate.spawn<SendPort>(
      getVideosTask,
      mainReceivePort.sendPort,
    );

    SendPort isolateSendPort = await mainReceivePort.first;

    ReceivePort isolateResponseReceivePort = ReceivePort();

    isolateSendPort.send(
      [index, isolateResponseReceivePort.sendPort],
    );

    final isolateResponse = await isolateResponseReceivePort.first;
    final urls = isolateResponse;

    add(
      VideoFeedEvent.updateUrls(urls),
    );
  }

  void getVideosTask(
    SendPort mainSendPort,
  ) async {
    ReceivePort isolateReceivePort = ReceivePort();

    mainSendPort.send(
      isolateReceivePort.sendPort,
    );

    await for (var message in isolateReceivePort) {
      if (message is List) {
        int index = message[0];
        SendPort isolateResponseSendPort = message[1];

        final List<String> urls = await _videoFeedRepsoitory.getVideos(
          id: index + Constants.preloadLimit,
        );

        isolateResponseSendPort.send(urls);
      }
    }
  }
}
