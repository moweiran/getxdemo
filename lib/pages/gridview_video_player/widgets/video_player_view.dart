import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerView extends StatefulWidget {
  final String url;
  const VideoPlayerView({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late final VideoPlayerController _controller =
      VideoPlayerController.network(widget.url);
  late Future<void> _initializeVideoPlayerFuture;
  bool _dispose = false;
  @override
  void initState() {
    _controller.setLooping(true);
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    print('${widget.url} dispose');
    if (_dispose) {
      _controller.dispose();
      _dispose = true;
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VideoPlayerView oldWidget) {
    print('${widget.url} didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 166,
      height: 190,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const VideoLoading();
          }
          return VisibilityDetector(
            key: Key(widget.url),
            onVisibilityChanged: _handleVisibilityDetector,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black,
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: ClipRRect(
                  child: Transform.scale(
                    scale: 1.03,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleVisibilityDetector(VisibilityInfo info) {
    if (kDebugMode) {
      print(' visibleFraction=${info.visibleFraction}');
    }
    if (info.visibleFraction == 1.0) {
      _controller.play();
    } else {
      _controller.pause();
    }
  }
}

class VideoLoading extends StatelessWidget {
  const VideoLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
