import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoDisplay extends StatefulWidget {
  final String url;

  const VideoDisplay({required this.url, Key? key}) : super(key: key);

  @override
  _VideoDisplayState createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  ChewieController? _chewieController;
  late VideoPlayerController _videoPlayerController;
  bool _isError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController,
              autoPlay: true,
              looping: false,
            );
          });
        }).catchError((error) {
          _handleError(error);
        });
    } catch (error) {
      _handleError(error);
    }
  }

  void _handleError(dynamic error) {
    print('Error initializing video player: $error');
    setState(() {
      _isError = true;
      _errorMessage = 'Error initializing video player: ${error.toString()}';
    });
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: _isError
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 40,
                  ),
                  SizedBox(height: 10),
                  Flexible(
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            : _chewieController != null &&
                    _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: Chewie(
                      controller: _chewieController!,
                    ),
                  )
                : CircularProgressIndicator(),
      ),
    );
  }
}
