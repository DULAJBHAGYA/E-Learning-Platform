import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoDisplay extends StatefulWidget {
  const VideoDisplay({Key? key});

  @override
  _VideoDisplayState createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer().then((controller) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: controller,
          autoPlay: true,
          looping: false,
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _chewieController != null
            ? Chewie(
                controller: _chewieController,
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Future<VideoPlayerController> _initializeVideoPlayer() async {
    final controller = VideoPlayerController.asset('videos/sample.mp4');
    await controller.initialize();
    return controller;
  }
}
